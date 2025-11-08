#!/bin/bash

set -e

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

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
  bpytop

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

bob use latest

mise use -g rust
mise use -g go
mise use -g node
mise use -g pnpm

curl -LsSf https://astral.sh/uv/install.sh | sh
