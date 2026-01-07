#!/bin/bash

if [[ $OSTYPE == "darwin"* ]]; then
  echo "this is macos"
  brew update
  brew install zsh
  brew install neovim
  brew install tmux
  brew install stow
  
  PACKAGE="eza"
  if command -v $PACKAGE > /dev/null; then
    echo "$PACKAGE is installed."
  else
    echo "installing $PACKAGE..."
    brew install $PACKAGE
    echo "finished installing $PACKAGE"
  fi

elif [[ $OSTYPE == "linux"* ]]; then 
  echo "this is linux"

  sudo apt update
  sudo apt install -y stow
  sudo apt install -y zsh
  sudo apt install -y neovim
  sudo apt install -y gpg
  sudo apt install -y tmux

  #Install eza (replacement for ls) currently linux only. Will fix for macos
  PACKAGE="eza"
  echo "Package $PACKAGE is not installed. Installing..."
  KEYRINGSDIR="/etc/apt/keyrings"
  if [ ! -d "$KEYRINGSDIR" ]; then
	  sudo mkdir -p "$KEYRINGSDIR"	
  else 
	  echo "keyrings directory already exists"
  fi
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg -y --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza
fi

# Install Pure prompt for all platforms only uses git
PUREDIR="$HOME/.zsh/pure"
if [ ! -d "$PUREDIR" ]; then
	git clone git@github.com:sindresorhus/pure.git "$PUREDIR"
else
	echo "Pure directory ($PUREDIR) already exists."
fi

#Install omz
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
	wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh 
	sh install.sh -y
	rm install.sh
else
	echo "omz already exists"

fi
 
#Remove bashrc zshrc nvim config
rm $HOME/.bashrc
rm $HOME/.zshrc
rm -rf $HOME/.config/nvim
stow .

rm $HOME/setup.sh
zsh
