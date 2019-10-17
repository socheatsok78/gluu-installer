#!/usr/bin/env bash

set -e

echo ">>> Login to the gluu-server vm..."
service gluu-server-${GLUU_VERSION} login < deploy.sh
