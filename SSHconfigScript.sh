#! /bin/bash

# Change SSH port to 2222 and harden SSH
sudo apt install -y openssh-server
sudo sed -ri.bak 's/.*Port.*/Port 2222/g' /etc/ssh/sshd_config
sudo sed -ri.bak 's/.*MaxAuthTries.*/MaxAuthTries 6/g' /etc/ssh/sshd_config
echo -e '# Allowed Users List\nAllowUsers god' | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Add Jamie's key to authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN94g9qIacaHRVN6x4UEA12dy/e7ZVGOm797+yfmPsq/ james@damnetwork.ca" >> ~/.ssh/authorized_keys

# Restart SSH
sudo systemctl restart sshd.service