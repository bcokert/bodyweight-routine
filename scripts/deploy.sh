#!/bin/bash

ssh -i .secrets-decrypted/deploy-key.pem ubuntu@fit.brandonokert.com <<'EOF'
echo ">>>cleanup past deploy failures"
rm -rf ~/artifact
rm -rf ~/files
EOF

echo -e "\n>>>copy over new artifacts and files to prod server"
scp -i .secrets-decrypted/deploy-key.pem -r artifact ubuntu@fit.brandonokert.com:~/artifact
scp -i .secrets-decrypted/deploy-key.pem -r deploy/files ubuntu@fit.brandonokert.com:~/files

ssh -i .secrets-decrypted/deploy-key.pem ubuntu@fit.brandonokert.com <<'EOF'
echo -e "\n>>>stop service, and remove old artifact"
if [[ "$(systemctl status | grep bodyweight-routine.service | grep -v grep)" != "" ]]; then
    sudo systemctl stop bodyweight-routine
fi
sudo systemctl stop bodyweight-routine
sudo rm -rf /opt/bodyweight-routine

echo -e "\n>>>copy over new artifact, and any file updates"
sudo mkdir -p /opt/bodyweight-routine/
sudo cp -r ~/artifact/* /opt/bodyweight-routine/
sudo cp -r ~/files/* /

echo -e "\n>>>cleanup after deploy"
rm -rf ~/artifact
rm -rf ~/files

echo -e "\n>>>tell systemd to keep our service up if it doesn't already"
if [[ "$(systemctl status | grep bodyweight-routine.service | grep -v grep)" == "" ]]; then
    sudo systemctl enable bodyweight-routine
fi

echo -e "\n>>>start our service"
sudo systemctl start bodyweight-routine
EOF
