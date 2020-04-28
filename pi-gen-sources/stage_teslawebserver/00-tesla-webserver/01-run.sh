#!/bin/bash -e
on_chroot << EOF
curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt install nodejs
node -v
npm -v
mkdir -p /root/src
cd /root/src
if [ ! -e /root/src/RP4 ]
then
  git clone -b teslausb https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/TronCam/RP4.git
  git clone https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/mcapraveen/pm2-logrotate.git
else
  cd /root/src/RP4
  git pull origin teslausb
fi
cd /root/src/RP4
npm i
npm install -g pm2

pm2 install pm2-logrotate

pm2 kill
EOF