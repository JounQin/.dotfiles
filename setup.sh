#!/bin/bash

set -e

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

setup_color() {
  # Only use colors if connected to a terminal
  if [ -t 1 ]; then
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

echo "${RED}Homebrew, Zsh, Oh-My-Zsh, Zinit and related apps and plugins will be installed automatically if not detected.${RESET}"

# check Homebrew installation
if ! command_exists brew; then
  echo "Installing Homebrew..."
  if [[ "$OSTYPE" != "darwin"* ]]; then
    if [ ! -f /etc/os-release ]; then
      sudo touch /etc/os-release
      sudo chown 1026:100 -R /etc/os-release
    fi
  fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  if [[ "$OSTYPE" != "darwin"* ]]; then
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.bash_profile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.profile
  fi
fi

# check zsh installation
if ! command_exists zsh; then
  echo "Installing Zsh..."
  brew install zsh
fi

## check Oh-My-Zsh installation
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

## check Zinit installation
if [ ! -d "$HOME/.local/share/zinit" ]; then
  echo "Installing Zinit..."
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

if [ "true" = "$CI" ]; then
  echo "${YELLOW}CI detected, copy zshrc automatically.${RESET}"
  \cp -f zshrc "$HOME/.zshrc"
else
  if read -t 5 -p "Copy or overwrite \`~/.zshrc\`? [y/N]: " -n 1 -r; then
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      \cp -f zshrc "$HOME/.zshrc"
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
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ "$(uname -m)" == "x86_64" ]]; then
      # mochi-diffusion: This software does not run on macOS versions older than Ventura.
      # Error: Cask playcover-community depends on hardware architecture being one of [{:type=>:arm, :bits=>64}], but you are running {:type=>:intel, :bits=>64}.
      export HOMEBREW_BUNDLE_CASK_SKIP="mochi-diffusion playcover-community"
      export HOMEBREW_BUNDLE_MAS_SKIP=$(grep "^mas.*id: \d*$" Brewfile | cut -d":" -f2 | paste -sd " " -)
    fi
  else
    export HOMEBREW_BUNDLE_BREW_SKIP="mas vscode"
  fi
  brew update
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
rcup brew-aliases starship SwitchHosts gitconfig gitignore zshrc

echo "Symlinking VSCode workspaces..."
WORKSPACE_SRC=~/.dotfiles/Workspaces
WORKSPACE_DEST=~/Workspaces
mkdir -p $WORKSPACE_DEST $WORKSPACE_DEST/Alauda $WORKSPACE_DEST/GitHub
ln -sf $WORKSPACE_SRC/Alauda.code-workspace $WORKSPACE_DEST
ln -sf $WORKSPACE_SRC/GitHub.code-workspace $WORKSPACE_DEST

echo -e "${GREEN}\xf0\x9f\x8e\x89 Congratulations, you have finished setting up!${RESET}"

if [[ "true" != "$CI" && ! $SHELL =~ \/zsh$ ]]; then
  echo "${BLUE}Toggling to zsh.${RESET}"
  exec zsh
fi
