# InCrowd-VI: A Realistic Visual–Inertial Dataset for Evaluating SLAM in Indoor Pedestrian-Rich Spaces for Human Navigation
<p align="center">
  <b><a href="https://www.mdpi.com/1424-8220/24/24/8164">Paper</a></b> |
  <b><a href="https://vault.cloudlab.zhaw.ch/vaults/InCrowd-VI/">InCrowd-VI Dataset</a></b>
</p>

<p align="center">
  <img src="https://github.com/banafshebamdad/InCrowd-VI/blob/main/images/InCrowd-VI_seq.png" alt="Example scenes from the InCrowd-VI dataset" width="800">
</p>
Example scenes from the InCrowd-VI dataset demonstrating various challenges: (a) high pedestrian density, (b) varying lighting conditions, (c) texture-poor surfaces, (d) reflective surfaces, (e) narrow aisles, and (f) stairs.


# InCrowd-VI Dataset
A realistic visual-inertial dataset with 58 sequences spanning 5km of trajectories and 1.5 hours of recordings, designed for evaluating SLAM systems in indoor pedestrian-rich environments. The dataset is particularly aimed at advancing navigation technologies for visually impaired individuals.

For more details, please refer to the accompanying [published paper](https://doi.org/10.3390/s24248164).

## File structure and documentation

Details on the file structure for each sequence are available on the [Sequence file structure](https://github.com/banafshebamdad/InCrowd-VI/wiki/Sequence-File-Structure) page. 
Additionally, you can find related documentation in the repository:
- [Calibration data](https://github.com/banafshebamdad/InCrowd-VI/wiki/Calibration-Data): Calibration parameters for cameras and IMUs used in the dataset.
- [InCrowd-VI sequences](https://github.com/banafshebamdad/InCrowd-VI/wiki/InCrowd-Vi-Sequences): Overview of sequences with density categories and main challenges.
  
Due to the large size of image files, the dataset provides `.vrs` files for each sequence. You can extract the necessary images locally using the tools available in this repository. 

---

## Getting started

### Requirements

The dataset generation tools have been tested on the following system configuration:

- **Operating system:** Ubuntu 22.04 LTS
- **Python version:** 3.10
- **System dependencies:**
```bash
sudo apt install python3.10-venv
```
To extract images from `.vrs` files, the `projectaria_tools` Python package is required. For detailed information about the package, refer to the official Meta documentation:
> - [Getting Started with Data Utilities](https://facebookresearch.github.io/projectaria_tools/docs/data_utilities/getting_started)
> - [Installation Instructions for Python](https://facebookresearch.github.io/projectaria_tools/docs/data_utilities/installation/installation_python)

#### Step 1. Setting up a virtual environment

To manage dependencies:
```bash
python3 -m venv $HOME/projectaria_tools_python_env
source $HOME/projectaria_tools_python_env/bin/activate
```
> ⚠️ **IMPORTANT:** Ensure the virtual environment is activated before running any dataset generation scripts.

#### Step 2. Install projectaria_tools
Upgrade pip and install the package:
```bash
python3 -m pip install --upgrade pip
python3 -m pip install projectaria-tools'[all]'
```
### Dataset download

The dataset sequences are publicly available at: [**InCrowd-VI Dataset**](https://vault.cloudlab.zhaw.ch/vaults/InCrowd-VI/)

### Extract data
The dataset was collected with [Meta Aria Project glasses](https://www.projectaria.com/) worn by a walking person. Aria data is recorded using VRS, an open-source file format. To extract data from `.vrs` files, use the provided scripts located in the [tools/dataset_generation](https://github.com/banafshebamdad/InCrowd-VI/tree/main/tools/dataset_generation) directory. These scripts process the `.vrs` file to undistort images and extract stereo and RGB images.

#### Required scripts

Ensure you download the following scripts from the [tools/dataset_generation](https://github.com/banafshebamdad/InCrowd-VI/tree/main/tools/dataset_generation) directory:
- `bb_generate_dataset_in_loop.sh`: Processes multiple `.vrs` files sequentially using the `bb_generate_sequence_ns.sh` script.
- `bb_generate_sequence_ns.sh`: Extracts and undistorts images from a `.vrs` file, organizes them by sensor type and timestamp unit, and generates a `timestamps.txt` file.
- `bb_image_undistortion.py`: Processes `.vrs` files to extract and undistort RGB and stereo images, saving both original and undistorted images with timestamps as filenames.

These scripts must be placed in the same directory before proceeding.

#### Steps to extract data

##### 1. Download the scripts

Download the required scripts from the repository's [tools/dataset_generation](https://github.com/banafshebamdad/InCrowd-VI/tree/main/tools/dataset_generation) directory. Place them in the desired directory.

##### 2. Select `.vrs` files for extraction 
Download the `.vrs` files from the [**InCrowd-VI Dataset**](https://vault.cloudlab.zhaw.ch/vaults/InCrowd-VI/data/). Then, open the `bb_generate_dataset_in_loop.sh` script and modify the `files=(...)` section.
Uncomment the block corresponding to the `vrs` files you want to process.

##### 3. Run the data generation script

Execute the script: 
```bash
bash bb_generate_dataset_in_loop.sh
```
> ⚠️ **IMPORTANT:** Ensure the virtual environment is activated before running this script.
> 
> ⚠️ **IMPORTANT:** Ensure that only one `files=(...)` block is uncommented at a time to avoid unintended behavior.


# Citation

If you use this dataset in an academic context, please cite the following paper:

> **Bamdad, M.; Hutter, H.-P.; Darvishy, A.**  
> **InCrowd-VI: A Realistic Visual–Inertial Dataset for Evaluating Simultaneous Localization and Mapping in Indoor Pedestrian-Rich Spaces for Human Navigation.**  
> *Sensors*, **2024**, *24*, 8164.  
> [https://doi.org/10.3390/s24248164](https://doi.org/10.3390/s24248164)


# Acknowledgments

Special thanks to the **Robotics and Perception Group** at the **University of Zurich** for providing the Meta Aria glasses used in this study.

# Support

If you have any questions or encounter issues, please create an [issue](https://github.com/banafshebamdad/InCrowd-VI/issues) in this repository. We will address it as soon as possible.



