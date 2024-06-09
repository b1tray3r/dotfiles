# Setup fzf
# ---------
if [[ ! "$PATH" == */home/aborgardt/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/aborgardt/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/aborgardt/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/aborgardt/.fzf/shell/key-bindings.zsh"
