#!/bin/bash

# Version regex
VER_REGEX='[0-9]+\.[0-9]+\.[0-9]+'

# Discord download URL
DISCORD_URL='https://discord.com/api/download/stable?platform=linux&format=deb'

# Get the currently installed version
LOCAL_LOC=$(dpkg -s discord | grep Version)
[[ $LOCAL_LOC =~ $VER_REGEX ]]
LOCAL_VER=${BASH_REMATCH[0]}

# Get the newest version from the download header
REMOTE_LOC=$(curl -sIkL "$DISCORD_URL" | grep location)
[[ $REMOTE_LOC =~ $VER_REGEX ]]
REMOTE_VER=${BASH_REMATCH[0]}

# Maybe update
if [ "$LOCAL_VER" = "$REMOTE_VER" ]; then
    echo "Up to date."
else
    # Run the update in an interactive terminal for the user
    gnome-terminal --wait -- /home/benjamin/discord/install-update.sh $DISCORD_URL $LOCAL_VER $REMOTE_VER
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

# Run discord
discord