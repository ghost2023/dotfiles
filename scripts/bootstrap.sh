#!/bin/bash

set -e

echo "Starting dotfiles bootstrap process..."

echo "Installing base-devel for AUR helper compilation..."
sudo pacman -S --needed base-devel

echo "Cloning paru AUR helper repository..."
git clone https://aur.archlinux.org/paru.git
cd paru
echo "Building and installing paru..."
makepkg -si
cd ..
rm -rf paru
echo "paru installed successfully."

echo "Installing core packages via paru (this may take a while)..."
paru -S --needed \
  ripgrep\
  fd\
  bob\
  bat\
  fzf\
  jq\
  lazygit\
  lazydocker\
  ghostty\
  tmux\
  stow\
  mise\
  xh\
  zen-browser-bin\
  telegram-desktop\
  docker\
  scrcpy\
  wl-clipboard\
  github-cli\
  bpytop\
  android-studio\
  android-sdk\
  android-sdk-platform-tools\
  otf-geist-mono-nerd\
  android-ndk
echo "Core packages installed."

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Oh My Zsh installed."

# Android Dev Setup
echo "Adding user to kvm group for Android emulator support..."
sudo usermod -aG kvm $USER
echo "User added to kvm group."

# The android-sdk package installs to /opt/android-sdk, which is owned by root.
# Change ownership to the current user to allow SDK management.
if [ -d "/opt/android-sdk" ]; then
    echo "Configuring Android SDK ownership and accepting licenses..."
    sudo chown -R $USER:$USER /opt/android-sdk

    # Accept SDK licenses
    yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses || echo "Failed to accept Android SDK licenses. Please run 'sdkmanager --licenses' manually."
    echo "Android SDK ownership changed and licenses accepted (if applicable)."
else
    echo "Android SDK directory /opt/android-sdk not found. Skipping chown and license acceptance."
fi

echo "Installing latest Neovim version via bob..."
bob use latest
echo "Neovim installed."

echo "Installing global Rust, Go, and Node.js versions via mise..."
mise use -g rust
mise use -g go
mise use -g node
echo "Rust, Go, and Node.js installed globally."

echo "Enabling Corepack for npm package management..."
npx corepack enable
echo "Corepack enabled."

echo "Adding user to docker group. You may need to log out and back in for this to take effect."
sudo usermod -aG docker $USER
echo "User added to docker group."

echo "Installing uv Python package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh
echo "uv installed."

echo "Installing global NPM tools via mise..."
mise use -g npm:@antfu/ni
mise use -g npm:@typescript/native-preview
mise use -g npm:@google/gemini-cli
mise use -g npm:eas-cli
mise use -g npm:opencode-ai
echo "Global NPM tools installed."

echo "Setting zsh as the default shell. You may need to log out and back in for this to take effect."
chsh -s $(which zsh)

echo "Stowing dotfiles into place..."
stow --adopt .
echo "Dotfiles stowed. Any existing conflicting files have been adopted."

echo "Bootstrap process complete! Please consider logging out and back in for all changes (like shell, group memberships, and environment variables) to take full effect."
