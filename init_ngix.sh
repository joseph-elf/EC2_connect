#!/bin/bash

# kill if error
set -e

source init_venv.sh

pip install fastapi uvicorn gunicorn

sudo apt update
sudo apt install nginx -y



sudo tee /etc/nginx/sites-available/fastapi > /dev/null << EOF
server {
    listen 80;      #lister ipv4:80
    listen [::]:80; #listen ipv6:80

    server_name _;  #catch all

    root /var/www/html; #static files user can access
    index index.html;   #default file openned


    location / {    #handle request starting by /
        try_files \$uri /index.html;
    }


    location /api/ {
    proxy_pass http://127.0.0.1:8000/;  # send request to local:8000, api
    proxy_set_header Host \$host;   #give the server domain to the api
    proxy_set_header X-Real-IP \$remote_addr;   #send the user ip to api
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;   
    proxy_set_header X-Forwarded-Proto \$scheme;    #tell the api if its http or https
    }
}
EOF


sudo ln -sf /etc/nginx/sites-available/fastapi /etc/nginx/sites-enabled/

sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t

sudo systemctl restart nginx

echo "To start the server run : uvicorn main:app --host 127.0.0.1 --port 8000 --reload"
echo "or run for deployment : bash start_fastapi.sh"






