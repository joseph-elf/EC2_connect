#!/bin/bash

# kill if error
set -e


sudo apt update
sudo apt install nginx -y



cat << EOF > /etc/nginx/sites-available/fastapi
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF


sudo ln -s /etc/nginx/sites-available/fastapi /etc/nginx/sites-enabled/


sudo rm /etc/nginx/sites-enabled/default

sudo nginx -t

sudo systemctl restart nginx
