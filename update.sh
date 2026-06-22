#!/bin/bash
sudo bash -c '
DB_ROOT_PASS=$(openssl rand -base64 16)
mariadb-secure-installation <<EOF
$DB_ROOT_PASS
y
y
y
y
EOF
echo "MariaDB root password: $DB_ROOT_PASS" > /root/db_credentials.txt
chmod 600 /root/db_credentials.txt'
