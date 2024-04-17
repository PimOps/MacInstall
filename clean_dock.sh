#!/bin/bash

# Script to remove specified applications from the Dock

# Function to remove an app from the Dock
remove_from_dock() {
    app_name="$1"
    echo "Removing $app_name from Dock..."
    defaults delete com.apple.dock persistent-apps
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$app_name.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

# List of applications to remove from Dock
declare -a dock_apps=("Launchpad" "Safari" "Messages" "Maps" "Photos" "FaceTime" "Contacts" "Reminders" "Notes" "Freeform" "TV" "Music" "App Store" "System Settings")

# Loop through the applications and remove them from the Dock
for app in "${dock_apps[@]}"; do
    remove_from_dock "$app"
done

# Change Dock animation to 'Scale Effect'
defaults write com.apple.dock mineffect -string "scale"

# Disable 'Show recent applications in Dock'
defaults write com.apple.dock show-recents -bool false

# Restart the Dock to apply changes
killall Dock

echo "Dock update completed."
