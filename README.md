# dotfiles

My configuration for Kubuntu linux.

## Chezmoi

This repository utilizes [chezmoi](https://www.chezmoi.io) to manage all the things related to configuration and productivity.

### Init

After installing chezmoi according to the documentation this repository can be initialized with:

```bash
chezmoi init git@github.com:b1tray3r/dotfiles.git
```

The script `run_onchange_install-packages.sh` will install all required software to run alacritty with starship, neovim, zoxide, lazygit and a nerd font.
