#!/bin/bash

# Script to configure Finder settings

# Don't show anything on the desktop
defaults write com.apple.finder CreateDesktop -bool false

# New Finder window opens in the home folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Configure sidebar items
# Note: These settings might vary based on macOS version and user preferences.
#       The following commands are a general guide and might need adjustment.
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder SidebarShowingiCloudDesktop -bool false
defaults write com.apple.finder SidebarShowingRecent -bool true
defaults write com.apple.finder SidebarShowingAirDrop -bool false
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show tab bar, status bar, and path bar
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Apply the changes by restarting Finder
killall Finder

echo "Finder configuration updated."
