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

echo "${RED}Homebrew, Zsh, Oh-My-Zsh, Zplugin and related apps and plugins will be installed automatically if not detected.${RESET}"

# check Homebrew installation
if ! command_exists brew
then
  echo "Installing Homebrew..."
  if [[ "$OSTYPE" == "darwin"* ]]
  then /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    brew install zsh
  fi
fi

## check Oh-My-Zsh installation
if [ ! -d "$HOME/.oh-my-zsh" ]
then
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

## check Zplugin installation
if [ ! -d "$HOME/.zplugin" ]
then
  echo "Installing Zplugin..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
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

execBrewBundle() {
  echo "Executing \`brew bundle\` to install packages and apps."
  echo "${BLUE}It may take some time until finishing at the first time, please be a bit patience...${RESET}"
  if [ "true" == "$CI" ]
  then
    brew update
    if [[ "$OSTYPE" != "darwin"* ]]
    then
      export HOMEBREW_BUNDLE_BREW_SKIP="ios-deploy mas"
      export HOMEBREW_BUNDLE_CASK_SKIP=$(brew bundle list --casks | paste -sd " " -)
    fi
    export HOMEBREW_BUNDLE_MAS_SKIP=$(brew bundle list --mas | paste -sd " " -)
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
rcup  brew-aliases SwitchHosts gitconfig gitignore gitproxy zshrc

echo "Symlinking VSCode workspaces..."
ln -sf ~/.dotfiles/Workspaces/Alauda.code-workspace ~/Workspaces
ln -sf ~/.dotfiles/Workspaces/GitHub.code-workspace ~/Workspaces

echo -e "${GREEN}\xf0\x9f\x8e\x89 Congratulations, you have finished setting up!${RESET}"

if [ "true" != "$CI" ]
then
  echo "${BLUE}Toggling to zsh.${RESET}"
  exec zsh
fi
