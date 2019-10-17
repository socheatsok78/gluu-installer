#!/usr/bin/env bash

set -e

GLUU_INSTALLER_REPO="https://github.com/socheatsok78/gluu-installer"
GLUU_INSTALLER_DIR="gluu-installer"

function apt_update() {
    echo ">>> Updating APT Repository..."
    apt-get update -qq
}

function apt_install_git() {
    echo ">>> Installing GIT..."
    apt-get install -y git
}

function clone_installer_repo() {
    echo ">>> Cloning $GLUU_INSTALLER_REPO to $GLUU_INSTALLER_DIR folder"

    if ! [ `command -v git` ]; then
        apt_update
        apt_install_git
    fi
    
    git clone "$GLUU_INSTALLER_REPO" "$GLUU_INSTALLER_DIR"
}

function gluu_setup() {
    # Check if directory exists
    if ! [ -d "$GLUU_INSTALLER_DIR" ]; then
        exit 1;  
    fi
    
    cd "$GLUU_INSTALLER_DIR"

    echo ">>> Checking executable"
    chmod +x ./install-gluu.sh
    chmod +x ./deploy.sh
    chmod +x ./scripts/post-install.sh

    echo ">>> Running scripts"
    ./install-gluu.sh
}

function main() {
    clone_installer_repo
    
    gluu_setup
}

# Running main()
main
