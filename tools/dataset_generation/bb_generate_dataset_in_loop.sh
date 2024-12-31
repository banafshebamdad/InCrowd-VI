#!/bin/bash

#
# Banafshe Marziyeh Bamdad
# banafshebamdad@gmail.com, bamdad@ifi.uzh.ch, marziyeh.bamdad@uzh.ch, bamz@zhaw.ch
# Sa Jul 20 06:09 CET
#
# This script sequentially processes a list of .vrs files using the bb_generate_sequence_ns.sh command. 
# The bb_generate_sequence_ns.sh script should be located in the same directory as this script.
# This script iterates through a predefined list of .vrs files, executing the command on each file one at a time. 
# The script ensures that each command completes before starting the next one, and it will terminate if an error occurs during the execution of any command. 
# 
# To use this script:
#   1. Uncomment the appropriate files=(...) block for the set of .vrs files you want to process. 
#   2. !!! IMPORTANT !!!: Ensure only one block is uncommented at a time to avoid unintended behavior.
#
#
# Usage:
# $ bash bb_generate_dataset_in_loop.sh
#


###
### InCrowd-VI dataset sequences
###

### Andreasstrasse_15 
# files=(
#   "/path/to/InCrowd-VI/Andreasstrasse_15/AND_Lib_floor5_1.vrs"
#   "/path/to/InCrowd-VI/Andreasstrasse_15/AND_Lib_floor5_2_narrow_ail.vrs"
#   "/path/to/InCrowd-VI/Andreasstrasse_15/AND_Lib_floor5_corridor.vrs"
#   "/path/to/InCrowd-VI/Andreasstrasse_15/AND_lift_A_to_Lift_C.vrs"
# )

### Binzmuhlestrasse_14  
# files=(
#  "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Binzmuhlestrasse_14/BIN_Hrsaal1B01_to_restroom.vrs"
# )

### ETH_Focus_Terra  
# files=(
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/ETH_Focus_Terra/ETH_focus_terra_2_challenging_light.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/ETH_Focus_Terra/ETH_focus_terra_entrance.vrs"
# )

### ETH_HG  
# files=(
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/ETH_HG/ETH_ground_floor.vrs"
# )

### ETH_Maschinenlaboratorium  
# files=(
#   "/path/to/InCrowd-VI/ETH_Maschinenlaboratorium/ETH_Maschinen_lab_corridor.vrs"
#   "/path/to/InCrowd-VI/ETH_Maschinenlaboratorium/ETH_Maschinen_lab_glass_wall.vrs"
# )

### Habsburgstrasse  
# files=(
#   "/path/to/InCrowd-VI/Habsburgstrasse/Habsburgstr_stairs_up_dark.vrs"
#   "/path/to/InCrowd-VI/Habsburgstrasse/Habsburgstr_stairs_up_light.vrs"
# )

### IMS_Labs partialy  
# files=(
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/IMS_Labs/IMS_Kochspannungslabor.vrs"
#   "/path/to/InCrowd-VI/IMS_Labs/IMS_TE21_LEA_lab.vrs"
#   "/path/to/InCrowd-VI/IMS_Labs/IMS_TE21_LEA_lab2.vrs"
# )

### Kriegsstrasse94  
# files=(
#   "/path/to/InCrowd-VI/Kriegsstrasse94/Kriegsstrasse94_1_pedestrian.vrs"
#   "/path/to/InCrowd-VI/Kriegsstrasse94/Kriegsstrasse94_1pedestrian_same_direction.vrs"
#   "/path/to/InCrowd-VI/Kriegsstrasse94/Kriegsstrasse94_static.vrs"
# )

### Migros  
# files=(
#   "/path/to/InCrowd-VI/Migros/Migris_low.vrs"
# )

### Oerlikon_Bahnhof  
# files=(
#   "/path/to/InCrowd-VI/Oerlikon_Bahnhof/Oerlikon_entrance_G7.vrs"
# )

### TH_building 
# files=(
#   "/path/to/InCrowd-VI/TH_building/TH_entrance_printer.vrs"
#   "/path/to/InCrowd-VI/TH_building/TH_printer_loop.vrs"
# )

### TS_buiding 
# files=(
#   "/path/to/InCrowd-VI/TS_buiding/TS_116_iwaitng_friend.vrs"
#   "/path/to/InCrowd-VI/TS_buiding/TS_entrance_cafe.vrs"
#   "/path/to/InCrowd-VI/TS_buiding/TS_stairs_up.vrs"
# )

### TS_exam 
# files=(
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/TS_exam/TS_exam_supervision_loop.vrs"
#   "/path/to/InCrowd-VI/TS_exam/TS_towards_exam_room.vrs"
# )

### UZH_HG 
# files=(
#   "/path/to/InCrowd-VI/UZH_HG/UZH_F_Floor_loop.vrs"
# )

### UZH_museum 
# files=(
#   "/path/to/InCrowd-VI/UZH_museum/UZH_musium_1.vrs"
#   "/path/to/InCrowd-VI/UZH_museum/UZH_musium_dinasors.vrs"
#   "/path/to/InCrowd-VI/UZH_museum/UZH_musium_under_ground_loop.vrs"
#   "/path/to/InCrowd-VI/UZH_museum/UZH_musium_wooden_stairs.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/UZH_museum/UZH_musium_wooden_staurs_up.vrs"
# )

### Winterthur_HB 
# files=(
#   "/path/to/InCrowd-VI/Winterthur_HB/G6_exit.vrs"
#   "/path/to/InCrowd-VI/Winterthur_HB/G6_loop.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Winterthur_HB/Getofftrain_pharmecy.vrs"
# )

### Zurich_Airport 
# files=(
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport/Zurich_airpoit_glass_bridge_service_center.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport/Zurich_airpoit_ochsner_sport.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport/Zurich_airpoit_ramp_checkin2.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport/Zurich_airpoit_shop.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport/Zurich_airpoit_toward_gates.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport/Zurich_airpoit_towards_checkin1.vrs"
# )

### Zurich_Airport_part2 
# files=(
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_arrival2_entrance.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_checkin2_large_loop.vrs"
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_entrance_checkin1_short_traj.vrs"
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_shopping_loop.vrs"
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_shopping_semi_loop.vrs"
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_short_loop.vrs"
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_towards_circle.vrs"
#   "/path/to/InCrowd-VI/Zurich_Airport_part2/Zurich_airpoit_turn180_degred.vrs"
# )

### Zurich_HB 
# files=(
#   "/path/to/InCrowd-VI/Zurich_HB/Cafe_exit.vrs"
#   "/path/to/InCrowd-VI/Zurich_HB/G8_cafe.vrs"
#   "/path/to/InCrowd-VI/Zurich_HB/Ground_53.vrs"
#   "/path/to/Documents/projectaria_sandbox/InCrowd-VI/Zurich_HB/Kiko_loop.vrs"
#   "/path/to/InCrowd-VI/Zurich_HB/Mainentrance_reservstionofgice.vrs"
#   "/path/to/InCrowd-VI/Zurich_HB/Orell_strait.vrs"
#   "/path/to/InCrowd-VI/Zurich_HB/Reservation_G17.vrs"
#   "/path/to/InCrowd-VI/Zurich_HB/Short_Loop.vrs"
# )

for file in "${files[@]}"
do
  source bb_generate_sequence_ns.sh "$file"
  if [ $? -ne 0 ]; then
    echo "Error running script on $file. Exiting."
    exit 1
  fi
done

