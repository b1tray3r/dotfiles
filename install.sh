#!/bin/zsh

for dir in */; do
  if [[ -d "$dir" ]]; then
    dirname="${dir%/}"
    stow -d $PWD -t $HOME $dirname
  fi
done

