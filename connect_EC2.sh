#!/bin/bash

if [[ ! -f ./config_EC2.sh ]]; then
    echo "❌ Error: config_EC2.sh not found in the current directory!"
    exit 1
fi

echo
echo "Openning config_EC2.sh :"

source ./config_EC2.sh

echo "🖥️ Trying to connect to "$IP
echo "as "$USERNAME
echo "with the key located in "$SSH_FILE
echo

REMOTE_COMMANDS="
    echo '✅ Connection to the EC2 instance is succesfull'
    echo
    echo '#################################################################'
    echo
    "


ssh -i $SSH_FILE -o StrictHostKeyChecking=no -t "$USERNAME@$IP" "$REMOTE_COMMANDS exec bash"

