#!/bin/bash

# install required packages
sudo apt-get install -y build-essential ripgrep zsh

# install nvim binary
sudo wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim.appimage -O /usr/sbin/local/nvim
sudo chmod +x /usr/local/sbin/nvim
mkdir ~/.config/nvim
git clone https://github.com/b1tray3r/nvim.git ~/.config/nvim

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo cp lazygit /usr/local/bin
rm lazygit.tar.gz lazygit

# Go
wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz
rm go1.23.1.linux-amd64.tar.gz
