#!/bin/bash

# Install Pure prompt

DIR="$HOME/.zsh/pure"
if [ ! -d "$DIR" ]; then
  git clone https://github.com/user/repo.git "$DIR"
  git clone https://github.com/sindresorhus/pure.git "$DIR"
else
  echo "Directory already exists."
fi

