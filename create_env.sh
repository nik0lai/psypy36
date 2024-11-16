#!/bin/bash

# Define the Conda environment name
ENV_NAME="psypy36"

# Find the path to conda
CONDA_PATH=$(which conda)

# If conda is not found, exit
if [ -z "$CONDA_PATH" ]; then
    echo "Error: conda not found in PATH"
    exit 1
fi

# Infer the base directory of the conda installation
CONDA_DIR=$(dirname $(dirname $CONDA_PATH))

# Source the conda.sh script to make 'conda activate' available
source "$CONDA_DIR/etc/profile.d/conda.sh"

# Create a Conda environment with Python 3.6
conda create --name $ENV_NAME python=3.6 --yes

# Now you can use 'conda activate'
conda activate $ENV_NAME

# Check if the environment was activated
if [ "$CONDA_PREFIX" != "$CONDA_DIR/envs/$ENV_NAME" ]; then
    echo "Error: Failed to activate the $ENV_NAME environment"
    exit 1
fi

# Change directory to the PsychoPy release folder
cd PsychoPy-2020.2.10

# Install Psychopy using pip
pip install . --ignore-installed certifi
pip install pyglet==1.4.4

# Install git to get access to other psychopy versions
conda install git --yes

# install pyqt5 to use GUI
pip install pyqt5

# not sure what is this for
conda install wxPython --yes

# this may be necessary 
# MESA-LOADER: failed to open radeonsi: /home/.../miniconda3/envs/psypy36/bin/../lib/libstdc++.so.6: version `GLIBCXX_3.4.30' not found (required by /opt/amdgpu/lib/x86_64-linux-gnu/libLLVM-17.so) (search paths /opt/amdgpu/lib/x86_64-linux-gnu/dri, suffix _dri)
conda install -c conda-forge libffi
