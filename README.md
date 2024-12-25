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
---

## Getting Started

### Dataset Download

The dataset and associated tools are publicly available at: [**InCrowd-VI Dataset**](https://vault.cloudlab.zhaw.ch/vault-data/incrowd-vi)

### File Structure

### Usage

#### Extract Data

#### Evaluation

## Citation

If you use this dataset in an academic context, please cite the following paper:

> **Bamdad, M.; Hutter, H.-P.; Darvishy, A.**  
> **InCrowd-VI: A Realistic Visual–Inertial Dataset for Evaluating Simultaneous Localization and Mapping in Indoor Pedestrian-Rich Spaces for Human Navigation.**  
> *Sensors*, **2024**, *24*, 8164.  
> [https://doi.org/10.3390/s24248164](https://doi.org/10.3390/s24248164)


## Acknowledgments

Special thanks to the **Robotics and Perception Group** at the **University of Zurich** for providing the Meta Aria glasses used in this study.

## Support

If you have any questions or encounter issues, please create an [issue](https://github.com/banafshebamdad/InCrowd-VI/issues) in this repository.  
We will address it as soon as possible.



