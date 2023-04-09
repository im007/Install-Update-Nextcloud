#!/bin/bash

# Fetch latest Nextcloud release info from GitHub's API
LATEST_RELEASE_JSON=$(curl -s https://api.github.com/repos/nextcloud/desktop/releases/latest)

# Extract the version number & remove "v" prefix
LATEST_VERSION=$(echo "$LATEST_RELEASE_JSON" | jq -r '.tag_name' | sed 's/^v//')

# Define location for Nextcloud AppImage
NEXTCLOUD_LOC="/home/$USER/.local/share/applications"
APPIMAGE_PATH="$NEXTCLOUD_LOC/Nextcloud.AppImage"

# Check if AppImage exists; extract version number & compare with the latest version
INSTALL_UPDATE=false
if [ -f "$APPIMAGE_PATH" ]; then
    INSTALLED_VERSION=$("$APPIMAGE_PATH" --version | grep version | cut -d' ' -f3)
    if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
        INSTALL_UPDATE=true
    else
        echo "Nextcloud is up-to-date; update not required."
    fi
else
    INSTALL_UPDATE=true
fi

if [ "$INSTALL_UPDATE" = true ]; then
    # Build the URL for the AppImage file, download & save as Nextcloud.AppImage
    APPIMAGE_URL="https://github.com/nextcloud/desktop/releases/download/v${LATEST_VERSION}/Nextcloud-${LATEST_VERSION}-x86_64.AppImage"
    wget -O Nextcloud.AppImage "$APPIMAGE_URL"

    # If Nextcloud is running, find its PID and kill it; otherwise, mention it's not running & continue
    pgrep -f "Nextcloud" && kill $(pgrep -f "Nextcloud") || echo "Nextcloud is not running, continuing with update."

    # Move the AppImage file to the defined location
    mv Nextcloud.AppImage $NEXTCLOUD_LOC

    # Make the AppImage executable
    chmod +x $APPIMAGE_PATH

    # Start the Nextcloud desktop client in the background
    nohup $APPIMAGE_PATH >/dev/null 2>&1 &

    # Notify the user that the update is complete
    echo "Nextcloud version $LATEST_VERSION installed."
fi
