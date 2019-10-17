#!/usr/bin/env bash

set -e

LINUX_DISTRO="$1" # linux distro
LINUX_CODENAME="$2" # linux codename

docker build . \
    -f "build/$LINUX_DISTRO/${LINUX_CODENAME}.Dockerfile" \
    --tag "gluu-installer:$LINUX_DISTRO-$LINUX_CODENAME"
