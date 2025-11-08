#!/bin/bash

set -e

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

chsh -s $(which zsh)

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
  zen-browser\
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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Android Dev Setup
sudo usermod -aG kvm $USER

# Set up Android environment variables for future sessions
sudo tee /etc/profile.d/android.sh > /dev/null <<'EOF'
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools
EOF

# The android-sdk package installs to /opt/android-sdk, which is owned by root.
# Change ownership to the current user to allow SDK management.
if [ -d "/opt/android-sdk" ]; then
    sudo chown -R $USER:$USER /opt/android-sdk

    # Accept SDK licenses
    yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses || echo "Failed to accept Android SDK licenses. Please run 'sdkmanager --licenses' manually."
else
    echo "Android SDK directory /opt/android-sdk not found. Skipping chown and license acceptance."
fi

bob use latest

mise use -g rust
mise use -g go
mise use -g node

npx corepack enable

sudo usermod -aG docker $USER

curl -LsSf https://astral.sh/uv/install.sh | sh

# NPM Tools
mise use -g npm:@antfu/ni
mise use -g npm:@typescript/native
mise use -g npm:@google/gemini-cli
mise use -g npm:eas-cli
mise use -g npm:opencode-ai


stow --adopt .
