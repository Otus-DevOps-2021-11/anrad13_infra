#!/bin/sh
apt-get update
apt-get install -y git
cd /opt
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

cd /etc/systemd/system
cat <<EOT > ./myreddit.service
[Unit]
Description=My Reddit Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/puma --dir /opt/reddit

[Install]
WantedBy=multi-user.target
EOT

chmod +x ./myreddit.service
systemctl daemon-reload
systemctl enable myreddit.service
systemctl start myreddit.service
