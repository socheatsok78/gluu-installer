#!/usr/bin/env bash

# Convert stirng to lower case
function lowercase() {
    echo $@ | tr '[:upper:]' '[:lower:]';
}

# Getting operitating system information
LSB_RELEASE_ID=$(lsb_release --id --short | lowercase)
LSB_RELEASE_CODENAME=$(lsb_release --codename --short)

# Variables
LINUX_DISTRO=${LSB_RELEASE_ID:-debian}
LINUX_CODENAME=${LSB_RELEASE_CODENAME:-stretch}

# Add repository to sources list
echo "Add repository to sources list..."
echo "deb https://repo.gluu.org/${LINUX_DISTRO}/ ${LINUX_CODENAME}-stable main" > /etc/apt/sources.list.d/gluu-repo.list

