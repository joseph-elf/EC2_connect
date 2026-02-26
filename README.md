# EC2_connect :

It is a small set of bash files used to prepare AWS EC2 instances for remote calculations.

### - Requirements :
- Your project folder has to be a git repository linked to $GIT_HUB_repo_of_the_project.
- Your project has to contain a config_EC2.sh file of this type:

```
\# USERNAME of the EC2 instance
USERNAME=ubuntu

\# IP of the EC2 instance
IP=16.171.14.230

\# SSH key file
SSH_FILE=~/.ssh/aws-rene.pem

\# Git-Hub repo of the project
GIT_HUB_repo_of_the_project=https://github.com/joseph-elf/Rene.git

\# Name of the project
NAME_of_the_project=Rene

\# Version of Python
PYTHON_VERSION=3.12
VENV_NAME=venv
```
- You have to have a EC2 instance ready to connect via ssh.





### - First Connection :

From your local repository, run
```
init_EC2.sh
```
You should now be connected to the instance and your Git-Hub repository is cloned.
Go to it with
```
cd project-name
```
You can now setup a python venv running
```
bash init_venv.sh
```
from the project folder which should contain 'requirements.txt' with lybrary to pip install.


### - Connection
Simply run
```
connect_EC2.sh
```
from the project folder containing config_EC2.sh.
