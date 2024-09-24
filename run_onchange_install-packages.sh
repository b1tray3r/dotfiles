#!/bin/bash

# install required packages
sudo apt-get install -y build-essential python3-pip python3-venv ripgrep zsh

# nerd font
declare -a fonts=(
    SourceCodePro
)

version='2.1.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv

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

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# starship prompt
curl -sS https://starship.rs/install.sh | sh
