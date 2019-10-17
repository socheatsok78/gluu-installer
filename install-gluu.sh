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

if [ "$LSB_RELEASE_ID" = "debian" ]; then
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
fi


echo "--------------------------------------------------"
echo "Distro: $LINUX_DISTRO"
echo "Codename: $LINUX_CODENAME"
echo "--------------------------------------------------"

# Add Gluu Repository
function gluu_add_repo() {
    GLUU_REPO="deb https://repo.gluu.org/${LINUX_DISTRO}/ ${LINUX_CODENAME} main"
    GLUU_REPO_FILE="/etc/apt/sources.list.d/gluu-repo.list"

    echo ">>> Add Gluu Repository: $GLUU_REPO"
    echo $GLUU_REPO > $GLUU_REPO_FILE
}

# Add Gluu GPG Key
function gluu_add_gpg() {
    GLUU_GPG_KEY="https://repo.gluu.org/${LINUX_DISTRO}/gluu-apt.key"

    echo ">>> Add Gluu GPG Key: $GLUU_GPG_KEY"
    curl "$GLUU_GPG_KEY" | apt-key add -
}

# Update/Clean Repo
function apt_clean() {
    echo ">>> Update/Clean Repo"
    apt-get update -q
}

# Install Gluu Server
function gluu_installer() {
    echo ">>> Install Gluu Server: gluu-server-${GLUU_VERSION}.${GLUU_BUILD}"
    apt-get install -y \
        "gluu-server-${GLUU_VERSION}.${GLUU_BUILD}"
}

# Start the server and log in
function gluu_start_service() {
    echo ">>> Starting gluu-server vm..."
    service gluu-server-${GLUU_VERSION} start
}

function main() {
    gluu_add_repo
    gluu_add_gpg
    apt_clean
    gluu_installer
    gluu_start_service
}


# Run main
main
