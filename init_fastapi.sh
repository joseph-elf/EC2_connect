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


sudo tee /etc/systemd/system/fastapi.service > /dev/null << EOF
[Unit]
Description=FastAPI App
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/API_rene
ExecStart=/home/ubuntu/venv/bin/gunicorn main:app -c /home/ubuntu/API_rene/config_gunicorn.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload

sudo systemctl start fastapi

sudo systemctl enable fastapi
