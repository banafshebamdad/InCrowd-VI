# InCrowd-VI Dataset

**InCrowd-VI** is a realistic visual-inertial dataset designed for evaluating Simultaneous Localization and Mapping (SLAM) systems in indoor pedestrian-rich environments. This dataset is particularly aimed at advancing navigation technologies for the visually impaired.

For more details, please refer to the [published paper](https://doi.org/10.3390/s24248164).

> ⚠️ **Note:** The documentation is in progress and will be available soon.

## Features

- **58 sequences** captured across diverse indoor public spaces (e.g., airports, train stations, libraries).
- **5 km total trajectory length** with 1.5 hours of recording time.
- Data includes:
  - RGB images (1408 × 1408 resolution, 30 FPS).
  - Stereo images (640 × 480 resolution, 30 FPS).
  - IMU measurements (1000 Hz and 800 Hz).
  - Ground-truth trajectories (accuracy ~2 cm).
  - Semi-dense 3D point clouds for each sequence.
- Captures real-world challenges such as varying crowd densities, occlusions, reflective surfaces, and lighting conditions.

## File Structure

Details on the file structure for each sequence are available on the [Sequnce File Structure](https://github.com/banafshebamdad/InCrowd-VI/wiki/Sequence-File-Structure) page. Due to the large size of image files, the dataset provides `.vrs` files for each sequence. You can extract the necessary images locally using the tools available in this repository. 

---

## Getting Started

### Requirements

The dataset generation tools have been tested on the following system configuration:

- **Operating system:** Ubuntu 22.04 LTS
- **Python version:** 3.10
- **Dependencies:**
```bash
python3 -m venv $HOME/projectaria_tools_python_env
source $HOME/projectaria_tools_python_env/bin/activate
```
To extract images from `.vrs` files, the `projectaria_tools` Python package is required. This package provides utilities for handling `.vrs` files effectively. For detailed information about the package, refer to the official Meta documentation:
> - [Getting Started with Data Utilities](https://facebookresearch.github.io/projectaria_tools/docs/data_utilities/getting_started)
> - [Installation Instructions for Python](https://facebookresearch.github.io/projectaria_tools/docs/data_utilities/installation/installation_python)

#### Step 1. Setting up a virtual environment

You must create and activate a virtual environment to manage all dependencies correctly. 
```bash
python3 -m venv $HOME/projectaria_tools_python_env
source $HOME/projectaria_tools_python_env/bin/activate
```
> ⚠️ **IMPORTANT:** Ensure the virtual environment is activated before running any dataset generation scripts.

#### Step 2. Install projectaria_tools
Once the virtual environment is activated, upgrade pip and install the projectaria_tools package from PyPI:
```bash
python3 -m pip install --upgrade pip
python3 -m pip install projectaria-tools'[all]'
```
### Dataset Download

The dataset and associated tools are publicly available at: [**InCrowd-VI Dataset**](https://vault.cloudlab.zhaw.ch/vault-data/incrowd-vi)

### File Structure

### Usage

### Extract Data
The dataset was collected with [Meta Aria Project glasses](https://www.projectaria.com/) worn by a walking person. Aria data is recorded using VRS, an open source file format. To extract data from `.vrs` files, use the provided scripts located in the `tools/dataset_generation` directory. These scripts process the `.vrs` file to retrieve calibration information, undistort images, extract stereo and RGB images, and IMU data.

#### Required Scripts

Ensure you download the following scripts from the `tools/dataset_generation` directory:
- `bb_accessing_device_calibration.py`  
- `bb_generate_dataset_in_loop.sh`  
- `bb_image_undistortion.py`  
- `bb_extract_IMU_data.py`  
- `bb_generate_sequence_ns.sh`  

These scripts must be placed in the same directory before proceeding.

#### Steps to Extract Data

##### 1. Download the Scripts

Obtain all the scripts listed above from the `tools/dataset_generation` directory of this repository. Place them in a directory where you intend to run the data extraction process.

##### 2. Select Files for Extraction

Open the `bb_generate_dataset_in_loop.sh` script and locate the `files=(...)` sections, which list `.vrs` files categorized by location.  
**Uncomment only one block** corresponding to the location or category of `.vrs` files you wish to extract.  

> ⚠️ **IMPORTANT:** Ensure that only one `files=(...)` block is uncommented at a time to avoid unintended behavior.

##### 3. Run the Data Generation Script

Execute the `bb_generate_dataset_in_loop.sh` script by running the following command in your terminal:

```bash
bash bb_generate_dataset_in_loop.sh
```


#### Evaluation

# Citation

If you use this dataset in an academic context, please cite the following paper:

> **Bamdad, M.; Hutter, H.-P.; Darvishy, A.**  
> **InCrowd-VI: A Realistic Visual–Inertial Dataset for Evaluating Simultaneous Localization and Mapping in Indoor Pedestrian-Rich Spaces for Human Navigation.**  
> *Sensors*, **2024**, *24*, 8164.  
> [https://doi.org/10.3390/s24248164](https://doi.org/10.3390/s24248164)


# Acknowledgments

Special thanks to the **Robotics and Perception Group** at the **University of Zurich** for providing the Meta Aria glasses used in this study.

# Support

If you have any questions or encounter issues, please create an [issue](https://github.com/banafshebamdad/InCrowd-VI/issues) in this repository.  
We will address it as soon as possible.



