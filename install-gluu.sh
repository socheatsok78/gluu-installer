#!/usr/bin/env bash

# Add repository to sources list
echo "Add repository to sources list..."
echo "deb https://repo.gluu.org/debian/ stretch-stable main" > /etc/apt/sources.list.d/gluu-repo.list
