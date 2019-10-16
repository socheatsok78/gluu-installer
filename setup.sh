#!/usr/bin/env bash

echo "Listing directory"
ls -la /install

cd /install/community-edition-setup/
./setup.py

exit 0;
