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
swapFile="/swap"
sudo dd if=/dev/zero of=$swapFile bs=1M count=1025
sudo chmod 600 $swapFile
sudo mkswap -f $swapFile
sudo swapon $swapFile
echo "$swapFile swap swap defaults 0 0" | sudo tee -a /etc/fstab
echo "59 23 * * 0 /sbin/reboot" | sudo crontab -
sudo apt update
sudo apt install htop btop unzip git curl wget fastfetch screen tmux tasksel traceroute apache2 apache2-doc mariadb-server mariadb-client php libapache2-mod-php php-mysql lsb-release locales python3 python3-pip python3-venv python3-dev python3-full pipx -y
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod expires
sudo systemctl restart apache2
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
sudo timedatectl set-timezone Asia/Jakarta
echo "LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_ALL=id_ID.UTF-8" | sudo tee /etc/locale.conf
echo "en_US.UTF-8 UTF-8
id_ID.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
sudo tailscale funnel --bg 80
sudo systemctl daemon-reload
sudo systemctl soft-reboot
