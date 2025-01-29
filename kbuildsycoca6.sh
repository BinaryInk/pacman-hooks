#!/bin/sh

# This script is intended to prevent 'open with...' dialogs from becoming
# unpopulated after updates to certain KDE Plasma components

# Sanity Check
if [ -z "$SUDO_USER" ]; then
    echo "This script is intended to be run as root by pacman as a hook."
else
    sudo -u "$SUDO_USER"  /usr/bin/kbuildsycoca6
fi
