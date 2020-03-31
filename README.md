# Neural Styles Automated Installer
- This repo is to make installing dependencies for convolutional neural networks with torch (tested on Ubuntu 18.04)

## Script Execution
- Make sure to run the scripts in order!
1. `bash pre-install.sh`
2. `bash install-part1.sh`
3. `bash install-part2.sh`
4. `bash install-part3.sh`
5. `bash neural-style.sh` (run within github.com/jcjohnson's "/neural-style" directory)

### Pre Install Script
- Pre-install.sh attempts to install the latest NVIDIA GPU drivers (not necessary if you've already installed).

### Install Pt. 1
- Installs Torch
- Installs Caffe
- Clones Neural Style repo
- Installs CUDA 

### Install Pt. 2
- Tests that part 1 was successful
- Installs CUDA backend for Torch
- Helps pre-install cuDNN

### Install Pt. 3
- Installs cuDNN from downloaded files

### Neural Style
- Runs neural styles test script

