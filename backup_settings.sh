#!/bin/bash

# Determine the directory where this script is located
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Create a backup directory inside the script's directory if it doesn't already exist
mkdir -p "$SCRIPT_DIR/SettingsBackup"

# Backup Dock settings
defaults read com.apple.dock > "$SCRIPT_DIR/SettingsBackup/dock-settings.plist"

# Backup Finder settings
defaults read com.apple.finder > "$SCRIPT_DIR/SettingsBackup/finder-settings.plist"

# Backup Network configurations
networksetup -listallnetworkservices > "$SCRIPT_DIR/SettingsBackup/network-services.txt"
for service in $(networksetup -listallnetworkservices | tail +2); do
    if [[ ! -z "$service" && "$service" != "An asterisk (*) denotes that a network service is disabled." ]]; then
        networksetup -getinfo "$service" > "$SCRIPT_DIR/SettingsBackup/${service// /_}-config.txt"
    fi
done
