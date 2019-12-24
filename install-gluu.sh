#!/usr/bin/env bash

set -e

# Check Official Gluu repository for more information
# https://repo.gluu.org/

source ./variables.sh

# Check operating system information
function check_system_info() {
    if [ -z "$LINUX_DISTRO" ] || [ -z "$LINUX_CODENAME" ]; then
        echo "Could not determind operating system distribution."
        exit 1
    fi
}

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
    echo ">>> Install Gluu Server: gluu-server"
    apt-get install -y \
        "gluu-server"
}

# Start the server and log in
function gluu_start_service() {
    echo ">>> Starting gluu-server vm..."

    if [ "$LINUX_CODENAME" = "stretch" ]; then
        /sbin/gluu-serverd enable
        /sbin/gluu-serverd start
    else
        service gluu-serverd start
    fi
}

function main() {
    check_system_info

    gluu_add_repo
    gluu_add_gpg
    apt_clean
    gluu_installer
    gluu_start_service
}


# Run main
main
