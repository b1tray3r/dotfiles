function runAct()
{
  if [[ ! -f ~/.config/act.env ]]; then
    echo "You have no act.env in your .config folder"
    return 1
  fi

  act --secret-file ~/.config/act.env -W $1
}
