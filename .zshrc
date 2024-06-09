if [ -f ~/.config/.env ]; then
    set -o allexport
        source ~/.config/.env
    set +o allexport
fi

# Custom snippet to source my configuration
if [ -d ~/.shell ]; then
    for file in ~/.shell/*.sh; do
        source "$file"
    done
fi

LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias ls="ls --color=auto"
alias ll='ls -alF'
alias gce='gh copilot explain'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

export GOPATH="/usr/local/go"
export PATH="$GOPATH/bin:$PATH"

export ANSIBLE_VAULT_PASSWORD_FILE=~/.config/ansible_vault

eval "$(zellij setup --generate-auto-start zsh)"
