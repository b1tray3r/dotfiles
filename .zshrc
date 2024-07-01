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

if [ -f ~/.alias ]; then
  source ~/.alias
fi

export LS_COLORS

export ANSIBLE_VAULT_PASSWORD_FILE=~/.config/ansible_vault
export PATH="$GOROOT/bin:$GOPATH:/opt/node/bin:$PATH"

setopt appendhistory
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/omp.yml)"

preexec() { print -Pn "\e]0; %~ \[$1\]\a" }
