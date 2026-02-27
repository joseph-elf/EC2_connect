#!/bin/bash

CONFIG_FILE=${1:-config_EC2.sh}

if [[ ! -f "./$CONFIG_FILE" ]]; then
    echo "❌ Error: $CONFIG_FILE not found in the current directory!"
    exit 1
fi
echo
echo "Opening $CONFIG_FILE :"
source "./$CONFIG_FILE"
echo

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

