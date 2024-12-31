#
# Banafshe Marziyeh Bamdad
# banafshebamdad@gmail.com, bamdad@ifi.uzh.ch, marziyeh.bamdad@uzh.ch, bamz@zhaw.ch
# Mon May 13 2024 15:17:58 CET
# 
# This script takes a VRS file, extracts all recorded RGB or SLAM-left and -right data, undistorts them, 
# and saves the original and undistorted images with the timestamp in micro- or nanoseconds as the filename.
#
# See https://facebookresearch.github.io/projectaria_tools/docs/data_utilities/advanced_code_snippets/image_utilities#image-undistortion
#
# Example of usage: 
#   $ python bb_image_undistortion.py --vrsfile /path/to/vrsfile.vrs --sensor_name camera-slam-left --sensor_id 1201-1 --timestamp_unit ns
# 

import argparse
from projectaria_tools.core import data_provider, calibration
from projectaria_tools.core.image import InterpolationMethod
from projectaria_tools.core.sensor_data import TimeDomain, TimeQueryOptions
from projectaria_tools.core.stream_id import RecordableTypeId, StreamId

import csv
import imageio
import numpy as np
import os

parser = argparse.ArgumentParser(description='Process VRS file and extract undistorted images.')
parser.add_argument('--vrsfile', required=True, help='Full path to the VRS file')
parser.add_argument('--sensor_name', required=True, help='Sensor name (camera-rgb, camera-slam-left, camera-slam-right)')
parser.add_argument('--sensor_id', required=True, help='Sensor ID')
parser.add_argument('--timestamp_unit', required=True, choices=['ns', 'ms'], help='Timestamp unit (ns for nanoseconds, ms for microseconds)')
args = parser.parse_args()

sensor_name = args.sensor_name
sensor_id = args.sensor_id
vrsfile = args.vrsfile
timestamp_unit = args.timestamp_unit

base_path = os.path.dirname(vrsfile)
images_home = os.path.join(base_path, 'sequences', os.path.basename(vrsfile).replace('.vrs', ''), f'{sensor_name.split("-")[-1]}_images')
path_to_images = os.path.join(images_home, timestamp_unit)

path_to_rectified_images = os.path.join(path_to_images, "undistorted")
path_to_origin_images = os.path.join(path_to_images, "origin")

os.makedirs(path_to_rectified_images, exist_ok=True)
os.makedirs(path_to_origin_images, exist_ok=True)

timestamp_file_path = os.path.join(images_home, "ts_association.txt")

provider = data_provider.create_vrs_data_provider(vrsfile)

# 
# Get sensor data in a sequence based on data capture time
# 

#
# Step 1. set preferred deliver options
#

# Obtain default options that provides the whole dataset from VRS
options = (
    provider.get_default_deliver_queued_options()
)
 
# A) truncate first/last time
# options.set_truncate_first_device_time_ns(int(370000000000))  # 11:06 secs after vrs first timestamp
# options.set_truncate_last_device_time_ns(int(1e9))  # 1 sec before vrs last timestamp

# A) deactivate all sensors then Activate only RGB
options.deactivate_stream_all()
stream_id = StreamId(sensor_id)
options.activate_stream(stream_id)
# slam_stream_ids = options.get_stream_ids(RecordableTypeId.SLAM_CAMERA_DATA)

# C) Subsample rate = 1 (do not skip any data per sensor)
options.set_subsample_rate(stream_id, 1)  # sample every data for camera

# 
# Step 2. create iterator to deliver data
# 

with open(timestamp_file_path, 'w', newline='') as timestamp_file:
    timestamp_writer = csv.writer(timestamp_file, delimiter=' ')
    
    iterator = provider.deliver_queued_sensor_data(options)
    total_imgs = 0
    for _ in iterator:  
        total_imgs += 1

    counter = 0

    # The iterator should be recreated because it is used in previous code block
    iterator = provider.deliver_queued_sensor_data(options)
    for sensor_data in iterator:
        counter += 1
        label = provider.get_label_from_stream_id(sensor_data.stream_id())
        sensor_type = sensor_data.sensor_data_type()
        device_timestamp = sensor_data.get_time_ns(TimeDomain.DEVICE_TIME)
        micro_sec = int(device_timestamp / 1000)
        
        timestamp_writer.writerow([device_timestamp, micro_sec])
        
        # Sensor data obtained by timestamp (nanoseconds) 
        # See http://localhost:8888/notebooks/dataprovider_quickstart_tutorial.ipynb#Sensor-data-can-be-obtained-by-timestamp-(nanoseconds)
        time_domain = TimeDomain.DEVICE_TIME  # query data based on DEVICE_TIME
        time_query_option = TimeQueryOptions.CLOSEST # get data whose time [in TimeDomain] is CLOSEST to query time
        image_data = provider.get_image_data_by_time_ns(stream_id, device_timestamp, time_domain, time_query_option)
        image_array = image_data[0].to_numpy_array()

        # Sensor calibration
        src_calib = provider.get_device_calibration().get_camera_calib(sensor_name)

        # create output calibration: a linear model of image size 1408x1408 and focal length 412.5 / 512x512, 150
        # Invisible pixels are shown as black.
        if sensor_name == "camera-rgb":
            dst_calib = calibration.get_linear_camera_calibration(1408, 1408, 412.5, sensor_name)
        elif sensor_name == "camera-slam-right":
            dst_calib = calibration.get_linear_camera_calibration(640, 480, 241.534, sensor_name)
        elif sensor_name == "camera-slam-left":
            dst_calib = calibration.get_linear_camera_calibration(640, 480, 241.511, sensor_name)
        else:
            raise ValueError("Unknown sensor name: {}".format(sensor_name))

        # Distort image
        rectified_array = calibration.distort_by_calibration(image_array, dst_calib, src_calib, InterpolationMethod.BILINEAR)

        # Save image
        img_name = device_timestamp if timestamp_unit == "ns" else micro_sec
        rectified_name = os.path.join(path_to_rectified_images, f"{img_name}.png")
        origin_name = os.path.join(path_to_origin_images, f"{img_name}.png")

        imageio.imwrite(rectified_name, rectified_array)
        imageio.imwrite(origin_name, image_array)

        print(sensor_name, " - ", counter, "/", total_imgs , " - ", img_name, timestamp_unit, " - ", vrsfile)

print(f"""Data obtained from {label} of type {sensor_type} with DEVICE_TIME: {device_timestamp} nanoseconds """)

