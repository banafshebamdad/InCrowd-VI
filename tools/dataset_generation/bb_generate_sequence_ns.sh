#!/bin/bash

#
# Banafshe Marziyeh Bamdad
# banafshebamdad@gmail.com, bamdad@ifi.uzh.ch, marziyeh.bamdad@uzh.ch, bamz@zhaw.ch
# Do Jul 11 17:42 CET
#

# This script automates the processing of a .vrs file to extract and undistort images from multiple sensors, 
# generate a directory structure for the extracted data, and create a timestamp association file. 
# The generated directory structure organizes images by sensor type and timestamp unit.
# It extracts images with filenames that include timestamps in nanoseconds.
# Additionally, the script produces a timestamps.txt file that lists the extracted image filenames in sorted order.

#
# Usage
#   $ source bb_generate_sequence.sh /path/to/the/file.vrs

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

declare -A sensors
sensors["camera-rgb"]="214-1"
sensors["camera-slam-left"]="1201-1"
sensors["camera-slam-right"]="1201-2"

create_sequences_directory() {
    vrs_dir=$(dirname "$vrs_file")

    sequences_dir="$vrs_dir/sequences"
    if [ ! -d "$sequences_dir" ]; then
        mkdir "$sequences_dir"
        echo -e "\n * Step 1. Directory 'sequences' created in $vrs_dir.\n"
    else
        echo -e "\n * Step 1. Directory 'sequences' already exists in $vrs_dir.\n"
    fi
}

generate_sequence_structure() {
    vrs_basename=$(basename "$vrs_file" .vrs)

    vrs_subdir="$sequences_dir/$vrs_basename"
    mkdir -p "$vrs_subdir"

}

extract_timestamps() {
    local sequence_name=$1
    local base_folder_path=$2
    local output_file="timestamps.txt"
    
    # Create or empty the output file
    > "$output_file"
    
    process_directory() {
      local folder_path=$1
      local output_dir=$2

      if [ ! -d "$folder_path" ]; then
        echo -e "\n${RED}Error: The folder $folder_path does not exist.${NC}\n"
        return
      fi

      # Extract filenames without extensions, sort them numerically, and write to the output file
      find "$folder_path" -name '*.png' | while read -r file; do
        basename "$file" .png
      done | sort -n >> "$output_dir/$output_file"

      echo -e "\n****** Step 6. Timestamps have been written to $output_dir/$output_file.\n"
    }

    for sensor in "left_images" "right_images" "rgb_images"; do
      for timestamp_unit in "ns"; do
        image_path="$base_folder_path/sequences/$sequence_name/${sensor}/${timestamp_unit}/undistorted"
        output_dir="$base_folder_path/sequences/$sequence_name/${sensor}/${timestamp_unit}"
        process_directory "$image_path" "$output_dir"
      done
    done
}

is_sourced() {
    [ "${BASH_SOURCE[0]}" != "${0}" ]
}

run_image_undistortion() {
    local vrs_file=$1
    local sensor_name=$2
    local sensor_id=$3
    local timestamp_unit=$4
    
    echo -e "\n**** Undistorting images for sensor_name=${sensor_name}, sensor_id=${sensor_id}, timestamp_unit=${timestamp_unit}...\n"
    
    python bb_image_undistortion.py --vrsfile "$vrs_file" --sensor_name "$sensor_name" --sensor_id "$sensor_id" --timestamp_unit "$timestamp_unit"
}

main() {
    if ! is_sourced; then
        echo -e "${RED}Error: This script needs to be sourced. Use 'source $0' instead of './$0' or 'bash $0'.${NC}"
        exit 1
    fi

    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 /path/to/vrs/file.vrs"
        exit 1
    fi

    vrs_file="$1"

    if [ ! -f "$vrs_file" ]; then
        echo "Error: File '$vrs_file' not found!"
        exit 1
    fi

    echo -e "\n... Process '$vrs_file' ..."
    
    start_time=$(date +%s)

    # Create sequences directory
    create_sequences_directory
    
    # Generate sequence structure
    generate_sequence_structure
    
    # Undistorting images for each sensor_name, sensor_id, and timestamp_unit combination
    for sensor_name in "${!sensors[@]}"; do
        sensor_id=${sensors[$sensor_name]}
        for timestamp_unit in "ns"; do
            run_image_undistortion "$vrs_file" "$sensor_name" "$sensor_id" "$timestamp_unit"
            echo ""
        done
    done
    
    # Extract timestamps for each image directory
    extract_timestamps "$(basename "$vrs_file" .vrs)" "$(dirname "$vrs_file")"
    
    end_time=$(date +%s)
    elapsed_time=$(($end_time - $start_time))
    
    if [ $elapsed_time -ge 3600 ]; then
      hours=$(($elapsed_time / 3600))
      minutes=$((($elapsed_time % 3600) / 60))
      seconds=$(($elapsed_time % 60))
      echo -e "\n\t${CYAN}Total execution time: ${hours} hours, ${minutes} minutes, and ${seconds} seconds.${NC}\n"
    elif [ $elapsed_time -ge 60 ]; then
      minutes=$(($elapsed_time / 60))
      seconds=$(($elapsed_time % 60))
      echo -e "\n\t${CYAN}Total execution time: ${minutes} minutes and ${seconds} seconds.${NC}\n"
    else
      echo -e "\n\t${CYAN}Total execution time: ${elapsed_time} seconds.${NC}\n"
    fi


    generated_data_size=$(du -sh "$vrs_subdir" | cut -f1)
    generated_data_size_mb=$(du -sm "$vrs_subdir" | cut -f1)
    generated_data_size_gb=$(bc <<< "scale=2; $generated_data_size_mb/1024")
    
    echo -e "\n\t${CYAN}Total generated data size: $generated_data_size_mb MB / $generated_data_size_gb GB${NC}\n"
    
    echo -e "\n\t${CYAN}Start date-time: $(date -d @$start_time)${NC}"
    echo -e "\n\t${CYAN}End date-time: $(date -d @$end_time)${NC}\n"
    
}

main "$@"

