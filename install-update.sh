#!/bin/bash

# Let the user know what updates are going on
echo "Discord needs to update $2 > $3"
# Confirm that the user actually wants to update
read -r -p "Do you want to update now? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]; then
    echo "Updating ..."
    # Find a temp file for the deb
    TEMP_DEB="$(mktemp)"
    # Gets the user to authenticate sudo so they don't have to do it later
    sudo test
    # Download the deb
    wget -O "$TEMP_DEB" "$1"
    # Install the deb
    sudo dpkg -i "$TEMP_DEB"
    # Clean up and exit
    rm -f "$TEMP_DEB"
    echo "Done, starting now"
    exit 0
else
    echo "Not updating or starting."
    exit 1
fi