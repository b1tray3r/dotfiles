#!/bin/bash

# install required packages
sudo apt-get install -y build-essential ripgrep

# install nvim binary
wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim.appimage -O ~/Downloads/nvim.appimage
mkdir ~/.config/nvim
git clone https://github.com/b1tray3r/nvim.git ~/.config/nvim
sudo mv ~/Downloads/nvim.appimage /usr/local/sbin/nvim

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
