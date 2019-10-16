#!/usr/bin/env bash

set -e

echo "Listing directory"
ls -la /install

cd /install/community-edition-setup

echo "Listing directory"
ls -la

./setup.py

exit 0;
