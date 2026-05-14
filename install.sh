#!/bin/bash
clear
sudo mv /etc/apt/sources.list /etc/apt/sources.list~
sudo mv /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources~
echo "#Debian
Types: deb deb-src
URIs: https://deb.debian.org/debian/
Suites: stable-backports-sloppy stable-backports stable-updates stable
Components: contrib main non-free-firmware non-free
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

#Debian Security
Types: deb deb-src
URIs: https://deb.debian.org/debian-security/
Suites: stable-security
Components: contrib main non-free-firmware non-free
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

#Debian Debug
Types: deb deb-src
URIs: https://deb.debian.org/debian-debug/
Suites: stable-backports-debug stable-backports-sloppy-debug stable-debug stable-proposed-updates-debug
Components: contrib main non-free-firmware non-free
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

#Debian Security Debug
Types: deb deb-src
URIs: https://deb.debian.org/debian-security-debug/
Suites: stable-security-debug
Components: contrib main non-free-firmware non-free
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/stable.sources
sudo apt update
swapFile="/swap"
sudo dd if=/dev/zero of=$swapFile bs=1M count=1025
sudo chmod 600 $swapFile
sudo mkswap -f $swapFile
sudo swapon $swapFile
echo "$swapFile swap swap defaults 0 0" | sudo tee -a /etc/fstab
sudo apt install htop btop git curl wget fastfetch screen tmux tasksel traceroute apache2 apache2-doc mariadb-server mariadb-client php libapache2-mod-php php-mysql lsb-release -y
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod expires
sudo systemctl restart apache2
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=tskey-auth-kN3i1Mi9fK11CNTRL-2Mv6Xsm5mWGazpobf3gfVGcRB1hRGtvnU
sudo tailscale funnel --bg 80
sudo poweroff
