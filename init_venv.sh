#!/bin/bash

set -e


if [[ ! -f ./config_EC2.sh ]]; then
    echo "❌ Error: config_EC2.sh not found in the current directory!"
    exit 1
fi
echo
echo "Openning config_EC2.sh :"
source ./config_EC2.sh
echo


if ! command -v python$PYTHON_VERSION &> /dev/null
then
    echo "Python $PYTHON_VERSION not found, installing..."
    sudo apt update
    sudo apt install -y python$PYTHON_VERSION python$PYTHON_VERSION-venv python$PYTHON_VERSION-distutils python$PYTHON_VERSION-dev python3-pip
else
    echo "Python $PYTHON_VERSION already installed."
fi

if [ -d "~/$VENV_NAME" ]; then
    echo "Removing existing virtual environment..."
    rm -rf $VENV_NAME
fi

echo "Creating virtual environment..."
python$PYTHON_VERSION -m venv ~/$VENV_NAME

source ~/$VENV_NAME/bin/activate

echo "Upgrading pip..."
pip install --upgrade pip

echo "Installing packages from requirements.txt..."
pip install -r requirements.txt

echo "✅ Environment setup complete! To activate later: source ~/$VENV_NAME/bin/activate"
