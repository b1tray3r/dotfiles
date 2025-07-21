if [ -f ~/.config/.env ]; then
    set -o allexport
        source ~/.config/.env
    set +o allexport
fi

export LS_COLORS
setopt appendhistory

# https://github.com/junegunn/fzf
if [[ ! -f /usr/bin/fzf ]]; then
  sudo pacman -S fzf
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# https://github.com/ajeetdsouza/zoxide
if [[ ! -f /usr/bin/zoxide ]]; then
  sudo pacman -S zoxide
fi
eval "$(zoxide init zsh)"

# https://starship.rs/
if [[ ! -f /usr/bin/starship ]]; then
  sudo pacman -S starship
fi
eval "$(starship init zsh)"

if [[ ! -f /home/aborgardt/.local/bin/getnf ]]; then
  curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
fi

if [[ ! -f /usr/bin/go ]]; then
  sudo pacman -S go
fi

# Alias

alias ls="ls --color=auto"
alias ll='ls -alF'
alias vim="nvim"
alias gg="lazygit"
alias sandbox="docker run --rm -d --name webtop -e PUID=$(id -u) -e PGID=$(id -g) -e TZ=Europe/Berlin -v "$HOME":/other -p 3000:3000 --shm-size=2g ghcr.io/linuxserver/webtop:ubuntu-xfce"
alias s="stow -d /home/aborgardt/workspace/dotfiles/archlinux/hyprland -t $HOME"
alias ssh="kitty +kitten ssh"

# Functions

function cgb()
{
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

# terminal hacks
# Fix to ctrl+r in terminal / kitty
bindkey '^R' history-incremental-search-backward
# Added ctrl+p for good measure, since that was also broken
bindkey '^P' up-history

