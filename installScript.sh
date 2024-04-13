#! /bin/bash

# Go v1.22.2 install 

echo Installing Go 1.22.2 

# Check if wget is installed - if not, install it so we can download the Go install package
if [ "$(dpkg -l | awk '/wget/ {print }'|wc -l)" -ge 1 ]; then
    sudo apt install wget
else
    echo WGET installed. Proceeding with Go install
fi

# If Go isn't installed - let's install it.
if [ "$(dpkg -l | awk '/go/ {print }'|wc -l)" -ge 1 ]; then
    echo Go already installed
else
    wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
    echo 'PATH=$PATH:/usr/local/go/bin' >>~/.profile
    # Reload .profile to force the changes
    source ~/.profile
fi

# Install NetData script for monitoring
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && sh /tmp/netdata-kickstart.sh --stable-channel --claim-token R54A9WMZU-T1EZ9gQFFC9LyhQcPw69RSEag_HNSCvbbujno25Buv-XOZzOjcYlypYTG7drK3Ohjqa-IYwfsp3sjmf9MkUaqrBMrBwu3WKd-qr7PDxLtF0agS52v1kkX-YbSJeJQ --claim-rooms e2d671c7-2cad-4aea-8545-4b8c2bcdbeb3 --claim-url https://app.netdata.cloud

# Install Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker

# Install Docker Compose (current version 2.26.1)
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
sudo docker compose version