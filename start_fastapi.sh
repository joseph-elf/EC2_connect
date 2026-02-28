






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
