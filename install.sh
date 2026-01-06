#!/bin/bash

if [[ $OSTYPE == "darwin"* ]]; then
  echo "this is macos"
  brew update

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
  sudo apt install -y gpg

  #Install eza (replacement for ls) currently linux only. Will fix for macos
  PACKAGE="eza"
  if dpkg -s $PACKAGE &> /dev/null; then
  	echo "Package $PACKAGE is already installed."
  else
  	echo "Package $PACKAGE is not installed. Installing..."
	  KEYRINGSDIR="/etc/apt/keyrings"
  	if [ ! -d "$KEYRINGSDIR" ]; then
  		sudo mkdir -p "$KEYRINGSDIR"
  	else 
  		echo "keyrings directory already exists"
  	fi
  	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  	sudo chmod 643 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  	sudo apt update
  	sudo apt install -y eza
  fi
fi

# Install Pure prompt for all platforms only uses git
PUREDIR="$HOME/.zsh/pure"
if [ ! -d "$PUREDIR" ]; then
	git clone https://github.com/user/repo.git "$PUREDIR"
	git clone https://github.com/sindresorhus/pure.git "$PUREDIR"
else
	echo "Pure directory ($PUREDIR) already exists."
fi

