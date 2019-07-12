#!/bin/sh

echo "Setting up rcm..."

## There is no doubt that zshrc should be overwrote because they should be exactly same.
rcup -f zshrc
rcup SwitchHosts gitconfig gitignore gitproxy

echo -e '\xf0\x9f\x8e\x89 Congratulations, you have finished setting up!'
