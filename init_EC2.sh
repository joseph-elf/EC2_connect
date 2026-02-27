#!/bin/bash

GIT_HUB_EC2_connect=https://github.com/joseph-elf/EC2_connect.git

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

REMOTE_COMMANDS="echo '✅ Connection to the EC2 instance is succesfull'
    echo

    git clone $GIT_HUB_EC2_connect;

    grep -qxF 'export PATH=\"\$HOME/EC2_connect:\$PATH\"' ~/.bashrc || \
    echo 'export PATH=\"\$HOME/EC2_connect:\$PATH\"' >> ~/.bashrc

    source ~/.bashrc;
    echo
    "


if [[ -z "$GIT_HUB_repo_of_the_project" ]]; then
    echo "⚠️ Git-Hub repo of the project is not defined, dont forget to clone it !"
    REMOTE_COMMANDS="$REMOTE_COMMANDS
    echo '⚠️ Git-Hub repo of the project is not defined, dont forget to clone it !'
    "
else 
    echo "and clone "$GIT_HUB_repo_of_the_project
    REMOTE_COMMANDS="$REMOTE_COMMANDS
    git clone $GIT_HUB_repo_of_the_project;
    "

fi

REMOTE_COMMANDS="$REMOTE_COMMANDS
    echo
    echo '#################################################################'
    echo
    "

echo 

ssh -i $SSH_FILE -o StrictHostKeyChecking=no -t "$USERNAME@$IP" "$REMOTE_COMMANDS exec bash"

