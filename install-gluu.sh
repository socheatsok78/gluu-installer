#!/usr/bin/env bash

set -e

# Version of Gluu to be installed
GLUU_VERSION=${GLUU_VERSION:-3.1.6}
GLUU_BUILD=sp1

# Convert stirng to lower case
function lowercase() {
    tr '[:upper:]' '[:lower:]';
}

# Getting operitating system information
export LSB_RELEASE_ID=$(lsb_release --id --short | lowercase)
export LSB_RELEASE_CODENAME=$(lsb_release --codename --short)

# Variables
LINUX_DISTRO=${LSB_RELEASE_ID}

case "$LSB_RELEASE_CODENAME" in
    "jessie")
        LINUX_CODENAME="stable"
    ;;
    "stretch")
        LINUX_CODENAME="stretch-stable"
    ;;
    *)
        LINUX_CODENAME=${LSB_RELEASE_CODENAME}
    ;;
esac

echo "--------------------------------------------------"
echo "Distro: $LINUX_DISTRO"
echo "Codename: $LINUX_CODENAME"
echo "--------------------------------------------------"

# Add Gluu Repository
APT_REPO="deb https://repo.gluu.org/${LINUX_DISTRO}/ ${LINUX_CODENAME} main"

echo ">>> Add Gluu Repository: $APT_REPO"
echo $APT_REPO > /etc/apt/sources.list.d/gluu-repo.list

# Add Gluu GPG Key
GPG_KEY="https://repo.gluu.org/${LINUX_DISTRO}/gluu-apt.key"

echo ">>> Add Gluu GPG Key: $GPG_KEY"
curl "$GPG_KEY" | apt-key add -

# Update/Clean Repo
echo ">>> Update/Clean Repo"
apt-get update

# Install Gluu Server
echo ">>> Install Gluu Server: gluu-server-${GLUU_VERSION}.${GLUU_BUILD}"
apt-get install -y "gluu-server-${GLUU_VERSION}.${GLUU_BUILD}"

# Start the server and log in
echo ">>> Starting gluu-server vm..."
service gluu-server-${GLUU_VERSION} start

echo ">>> Login to the gluu-server vm..."
service gluu-server-${GLUU_VERSION} login < setup.sh
