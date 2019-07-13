#!/bin/sh

set -e

command_exists() {
	command -v "$@" >/dev/null 2>&1
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

if ! command_exists zsh; then
  echo "${YELLOW}Zsh is not installed.${RESET} Please install zsh first."
  exit 1
fi

if read -t 5 -p "Copy or overwrite \`~/.zshrc\`? [y/N]: " answer; then
  if [ "y" == "$answer" ]; then
    \cp -f zshrc $HOME/.zshrc;
  fi
else
  echo
  echo "Exit automatically due to timeout..."
  exit 0
fi

echo "${RED}Homebrew, Oh-My-Zsh, zplug and related apps and plugins will be installed automatically if not detected.${RESET}"
echo "${BLUE}Toggling to zsh, it may take some time until finishing at first time, please be a bit patience...${RESET}"

SETUP_COMMAND="bash setup.sh"

echo "${YELLOW}Please remember to run \`$SETUP_COMMAND\` after installation.${RESET}"

COPIED=0

if command_exists pbcopy; then
  echo -n $SETUP_COMMAND | pbcopy
  COPIED=1
else
  if command_exists xclip; then
    echo -n $SETUP_COMMAND | xclip -selection c
    COPIED=1
  fi
fi

if [ "1" == "$COPIED" ]; then
  echo "${GREEN}command \`$SETUP_COMMAND\` has been copied to clipboard automatically.${RESET}"
fi

zsh
