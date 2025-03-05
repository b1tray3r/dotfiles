#!/bin/bash

# install required packages
sudo apt-get install -y build-essential python3-pip python3-venv yq ripgrep zsh tmux

bash installNerdFont.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/SourceCodePro.zip

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
tmux kill-server

# install nvim binary
sudo wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim.appimage -O /usr/sbin/local/nvim
sudo chmod +x /usr/sbin/local/nvim

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

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# starship prompt
curl -sS https://starship.rs/install.sh | sh
