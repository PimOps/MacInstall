#!/bin/bash

# Determine the directory where this script is located
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Restore Dock settings
defaults write com.apple.dock < "$SCRIPT_DIR/SettingsBackup/dock-settings.plist"
killall Dock

# Restore Finder settings
defaults write com.apple.finder < "$SCRIPT_DIR/SettingsBackup/finder-settings.plist"
killall Finder

# Restoring network configurations and other settings would need to be handled individually based on how they were saved.
