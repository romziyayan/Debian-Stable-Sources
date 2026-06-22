#!/bin/bash

clear

if [ "$EUID" -ne 0 ]; then
  echo "Elevating privileges..."
  exec sudo "$0" "$@"
fi

apt update
apt upgrade -y
