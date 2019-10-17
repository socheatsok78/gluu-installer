#!/usr/bin/env bash

set -e

GLUU_WORKDIR="/install/community-edition-setup"

# Accept MIT license
echo 'yes'

echo ">>> Changing working directory to: $GLUU_WORKDIR"
cd "$GLUU_WORKDIR"

echo ">>> Starting setup.py script"
./setup.py

# Print setup.log
if [ -f "$GLUU_WORKDIR/setup.log" ]; then
    echo ">>> Setup log"
    cat "$GLUU_WORKDIR/setup.log"
fi

# Print setup_error.log
if [ -f "$GLUU_WORKDIR/setup_error.log" ]; then
    echo ">>> Error log"
    cat "$GLUU_WORKDIR/setup_error.log"
fi

