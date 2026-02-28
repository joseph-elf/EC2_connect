#!/bin/bash

# kill if error
set -e

source init_venv.sh

pip install fastapi uvicorn gunicorn

sudo apt update
sudo apt install nginx -y



sudo tee /etc/nginx/sites-available/fastapi > /dev/null << EOF
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


sudo ln -sf /etc/nginx/sites-available/fastapi /etc/nginx/sites-enabled/

sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t

sudo systemctl restart nginx

echo "To start the server run : uvicorn main:app --host 127.0.0.1 --port 8000 --reload"
echo "or run for deployment : bash start_fastapi.sh"






