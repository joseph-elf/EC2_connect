#!/bin/bash

GIT_HUB_EC2_connect=https://github.com/joseph-elf/EC2_connect.git


REMOTE_COMMANDS="
echo 'HEY'
git clone $GIT_HUB_EC2_connect;
ls -a;
grep -qxF 'export PATH=\"\$HOME/EC2_connect:\$PATH\"' ~/.bashrc || \
echo 'export PATH=\"\$HOME/EC2_connect:\$PATH\"' >> ~/.bashrc
source ~/.bashrc;
"


if [[ ! -f ./config_EC2.sh ]]; then
    echo "Error: config_EC2.sh not found in the current directory!"
    exit 1
fi
echo "Openning config_EC2.sh :"

source ./config_EC2.sh

echo "Trying to connect to "$IP
echo "as "$USERNAME
echo "with the key located in "$SSH_FILE

ssh -i $SSH_FILE -o StrictHostKeyChecking=no -t $USERNAME@$IP "$REMOTE_COMMANDS exec bash"