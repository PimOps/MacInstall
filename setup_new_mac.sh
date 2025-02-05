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
for app in authy betterdisplay caffeine cloudflare-warp drawio grishka/grishka/neardrop lulu mac-mouse-fix microsoft-edge microsoft-office microsoft-teams openvpn-connect parallels postman powershell spotify telegram visual-studio-code WhatsApp zoom

## Removed apps: hiddenbar logi-options-plus miniconda

do
    brew install --cask $app || echo "Failed to install $app" >> setup_errors.log
done

# Miniconda shell fix
echo "Initializing Miniconda..."
conda init "$(basename "${SHELL}")" || echo "Failed to initialize Miniconda" >> setup_errors.log

# Install brew core apps, logging errors
echo "Installing core applications..."
for app in graphviz mas node
do
    brew install $app || echo "Failed to install $app" >> setup_errors.log
done

# Install apps from the App Store in alphabetical order, logging errors
echo "Installing applications from the App Store..."
for id in 869223134 1352778147 1452453066 417375580
do
    mas install $id || echo "Failed to install App Store app with ID $id" >> setup_errors.log
done

# Configure scripts
echo "Configuring system scripts..."
chmod +x remove_from_dock.sh && ./remove_from_dock.sh || echo "Failed to run remove_from_dock.sh" >> setup_errors.log
chmod +x configure_finder.sh && ./configure_finder.sh || echo "Failed to run configure_finder.sh" >> setup_errors.log

echo "Installation and configuration complete! Check setup_errors.log for any issues."
