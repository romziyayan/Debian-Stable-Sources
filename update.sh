#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "This script requires root privileges. Elevating via sudo..."
  exec sudo "$0" "$@"
fi

mv /etc/apt/sources.list /etc/apt/sources.list~
mv /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources~
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
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" | tee /etc/apt/sources.list.d/stable.sources
swapFile="/swap"
dd if=/dev/zero of=$swapFile bs=1M count=1025
chmod 600 $swapFile
mkswap -f $swapFile
swapon $swapFile
echo "$swapFile swap swap defaults 0 0" | tee -a /etc/fstab
echo "59 23 * * 0 /sbin/reboot" | crontab -
apt update
apt install htop btop git curl wget fastfetch screen tmux tasksel traceroute apache2 apache2-doc mariadb-server mariadb-client php libapache2-mod-php php-mysql lsb-release locales python3 python3-pip python3-venv python3-dev python3-full pipx nodejs npm -y
DB_ROOT_PASS=$(openssl rand -base64 16)
mariadb-secure-installation <<EOF
$DB_ROOT_PASS
y
y
y
y
EOF
echo "MariaDB root password: $DB_ROOT_PASS" > /root/db_credentials.txt
chmod 600 /root/db_credentials.txt
a2enmod rewrite
a2enmod headers
a2enmod expires
systemctl restart apache2
echo "<?php phpinfo(); ?>" | tee /var/www/html/info.php
timedatectl set-timezone Asia/Jakarta
echo "LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_ALL=id_ID.UTF-8" | tee /etc/locale.conf
echo "en_US.UTF-8 UTF-8
id_ID.UTF-8 UTF-8" | tee -a /etc/locale.gen
locale-gen
tailscale funnel --bg 80
