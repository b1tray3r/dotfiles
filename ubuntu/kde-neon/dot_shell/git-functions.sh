function clean-git-branches()
{
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}
