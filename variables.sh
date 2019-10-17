#!/usr/bin/env bash

# set -e

# Check Official Gluu repository for more information
# https://repo.gluu.org/

# Version of Gluu to be installed
export GLUU_VERSION=${GLUU_VERSION:-3.1.6}
export GLUU_BUILD=sp1

# Convert stirng to lower case
function lowercase() {
    tr '[:upper:]' '[:lower:]';
}

# Getting operitating system information
export LSB_RELEASE_ID=$(lsb_release --id --short | lowercase)
export LSB_RELEASE_CODENAME=$(lsb_release --codename --short)

# Variables
export LINUX_DISTRO=${LSB_RELEASE_ID:-ubuntu}

if [ "$LSB_RELEASE_ID" = "debian" ]; then
    case "$LSB_RELEASE_CODENAME" in
        "stretch")
            export LINUX_CODENAME="stretch-stable"
        ;;
        *)
            export LINUX_CODENAME="stable"
        ;;
    esac
else
    export LINUX_CODENAME=${LSB_RELEASE_CODENAME:-xenial}
fi

# Print system information
echo "--------------------------------------------------"
echo "Distro: $LINUX_DISTRO"
echo "Codename: $LINUX_CODENAME"
echo "--------------------------------------------------"
