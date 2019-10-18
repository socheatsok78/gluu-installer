#!/usr/bin/env bash

set -e

LINUX_DISTRO="$1" # linux distro
LINUX_CODENAME="$2" # linux codename

ARGS="$3 $4 $5 $6 $7 $8"

docker build . \
    -f "build/$LINUX_DISTRO/${LINUX_CODENAME}.Dockerfile" \
    --tag "gluu-installer:$LINUX_DISTRO-$LINUX_CODENAME" \
    $ARGS
