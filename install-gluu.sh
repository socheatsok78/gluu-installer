#!/usr/bin/env bash

# Version of Gluu to be installed
GLUU_VERSION=${GLUU_VERSION:-3.1.6.sp1}

# Convert stirng to lower case
function lowercase() {
    echo $@ | tr '[:upper:]' '[:lower:]';
}

# Getting operitating system information
LSB_RELEASE_ID=$(lsb_release --id --short | lowercase)
LSB_RELEASE_CODENAME=$(lsb_release --codename --short)

# Variables
LINUX_DISTRO=${LSB_RELEASE_ID:-debian}

case "$LSB_RELEASE_CODENAME" in
    "jessie")
        LINUX_CODENAME="stable"
    ;;
    "stretch")
        LINUX_CODENAME="stretch-stable"
    ;;
    *)
        LINUX_CODENAME=${LSB_RELEASE_CODENAME:-xenial}
    ;;
esac

# Add Gluu Repository
echo "Add Gluu Repository"
echo "deb https://repo.gluu.org/${LINUX_DISTRO}/ ${LINUX_CODENAME} main" > /etc/apt/sources.list.d/gluu-repo.list

# Add Gluu GPG Key
echo "Add Gluu GPG Key"
curl https://repo.gluu.org/debian/gluu-apt.key | apt-key add -

# Update/Clean Repo
echo "Update/Clean Repo"
apt-get update

# Install Gluu Server
echo "Install Gluu Server"
apt-get install "gluu-server-${GLUU_VERSION}"
