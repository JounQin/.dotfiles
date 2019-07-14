#!/bin/sh

set -e

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]
  then
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		RESET=""
	fi
}

setup_color

echo "${RED}Homebrew, Zsh, Oh-My-Zsh, zplug and related apps and plugins will be installed automatically if not detected.${RESET}"

# check Homebrew installation
if [ ! -x "$(command -v brew)" ]
then
  echo "Installing Homebrew..."
  if [[ "$OSTYPE" == "darwin"* ]]
  then /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    brew install zsh
  fi
fi

if ! command_exists zsh
then
  echo "${YELLOW}Zsh is not installed.${RESET} Please install zsh first."
  exit 1
fi

if [ "true" == "$CI" ]
then
  echo "${YELLOW}CI detected, copy zshrc automatically.${RESET}"
  \cp -f zshrc $HOME/.zshrc
else
  if read -t 5 -p "Copy or overwrite \`~/.zshrc\`? [y/N]: " -n 1 -r
  then
    if [[ $REPLY =~ ^[Yy]$ ]]
      then \cp -f zshrc $HOME/.zshrc
    fi
  else
    echo
    echo "Exit automatically due to timeout..."
    exit 0
  fi
fi

## check Oh-My-Zsh installation
if [ ! -d "$ZSH" ]
then
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

execBrewBundle() {
  echo "Executing \`brew bundle\` to install packages and apps."
  echo "${BLUE}It may take some time until finishing at the first time, please be a bit patience...${RESET}"
  if [ "true" == "$CI" ]
  then
    brew update
    mas signin "$EMAIL" "$PASSWORD"
  fi
  brew bundle
}

execBrewBundle || {
  echo "${YELLOW}Error occurred, retrying.${RESET}"
  execBrewBundle || {
    echo "${RED}Retried but failed, exiting...${RESET}"
    exit 1
  }
}

echo "Setting up rcm..."
rcup SwitchHosts gitconfig gitignore gitproxy zshrc

echo -e "${GREEN}\xf0\x9f\x8e\x89 Congratulations, you have finished setting up!${RESET}"

if [ "true" != "$CI" ]
then
  echo "${BLUE}Toggling to zsh.${RESET}"
  zsh
fi
