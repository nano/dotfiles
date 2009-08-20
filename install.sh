#!/bin/sh

if [ $# -gt 0 ]; then
  dotfiles=$@
else
  dotfiles=$(ls -A | grep -v "\.git$" | grep -v install.sh)
fi

for i in $dotfiles; do
  echo $i
  if [ -f "$HOME/$i" ]; then
    mv "$HOME/$i" "$HOME/$i.bak"
  fi
  ln -s "$(pwd)/$i" "$HOME/$i"
done
