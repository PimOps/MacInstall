#!/bin/bash

# Function to check if Homebrew is installed
function check_brew {
    if ! command -v brew &> /dev/null
    then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [ $? -ne 0 ]; then
            echo "Failed to install Homebrew" >> setup_errors.log
        fi
    else
        echo "Homebrew is already installed."
    fi
}

# Remind user to grant Full Disk Access
echo "Please ensure that Terminal has 'Full Disk Access' in system settings to avoid installation issues, especially with Parallels."
read -p "Press [Enter] once you have granted access..."

# Check and install Homebrew
check_brew

# Install brew casks in alphabetical order, logging errors
echo "Installing applications via Homebrew Cask..."
for app in betterdisplay firefox mac-mouse-fix microsoft-teams spotify visual-studio-code WhatsApp zoom

do
    brew install --cask $app || echo "Failed to install $app" >> setup_errors.log
done


# Install apps from the App Store in alphabetical order, logging errors
echo "Installing applications from the App Store..."
for id in \
    1352778147 # Bitwarden
    417375580  # BetterSnapTool
do
    mas install $id || echo "Failed to install App Store app with ID $id" >> setup_errors.log
done



echo "Installation and configuration complete! Check setup_errors.log for any issues."
