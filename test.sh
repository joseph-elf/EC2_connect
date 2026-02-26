echo "HEY It worked"



if ! dpkg -s python$PYTHON_VERSION-distutils &> /dev/null; then
    echo "Installing python$PYTHON_VERSION-distutils... ⚙️"
    sudo apt update
    sudo apt install -y python$PYTHON_VERSION-distutils
else
    echo "python$PYTHON_VERSION-distutils already installed ✅"
fi
