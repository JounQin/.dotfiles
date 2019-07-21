# .dotfiles [![Travis](https://img.shields.io/travis/com/JounQin/.dotfiles.svg)](https://travis-ci.com/JounQin/.dotfiles)

Personal but sharable .dotfiles managed by `rcm`.

## Usage

```sh
git clone https://github.com/JounQin/.dotfiles.git ~/.dotfiles
bash ~/.dotfiles/setup.sh
```

## Explanation

### rcm

[rcm](https://github.com/thoughtbot/rcm) is a `rc file (dotfile) management`, it is used to back up all of our sharable dotfiles.

Useful commands:

- [rcup] is the main program. It is used to install and update dotfiles, with support for tags, host-specific files, and multiple source directories.
- [rcdn] is the opposite of [rcup].
- [mkrc][mkrc] is for introducing a dotfile into your dotfiles directory, with support for tags and multiple source directories.
- [lsrc] shows you all your dotfiles and where they would be symlinked to. It is used by [rcup] but is provided for your own use, too.

[rcup]: http://thoughtbot.github.io/rcm/rcup.1.html
[mkrc]: http://thoughtbot.github.io/rcm/mkrc.1.html
[rcdn]: http://thoughtbot.github.io/rcm/rcdn.1.html
[lsrc]: http://thoughtbot.github.io/rcm/lsrc.1.html

### Homebrew

[Homebrew](https://brew.sh) is `The missing package manager for macOS (or Linux)`, it is used to manage all packages and apps (with `brew cask` and [mas](https://github.com/mas-cli/mas)).
And [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) bundles them together.

Useful commands:

- Run `brew bundle dump` to generate a file named `Brewfile` according to your installed taps, packages and apps.

- Run `brew bundle` to check and install packages and apps via `Brewfile`, just change it as you wish.

  You may need to move the apps which are not managed by `brew cask` or `mas` to trash.

  _AND_ do not delete any of your app data, be careful!

### Zplugin and Oh-My-Zsh

[Zplugin](https://github.com/zdharma/zplugin) is a `Flexible Zsh plugin manager with clean fpath, reports, completion management, turbo mode, services`, and [Oh My Zsh](https://ohmyz.sh) is a `framework for managing your` [zsh](https://www.zsh.org) `configuration`,
they are used to make our terminal more beautiful and productive.

I was always using official `apple` theme before I meet [spaceship](https://github.com/denysdovhan/spaceship-prompt).

Just change file `zshrc` if you want to modify the zsh plugins, theme, aliases or exports, etc.

### Proxy

It is assumed that you're using [SSR](https://github.com/qinyuhang/ShadowsocksX-NG-R) to across THE GREAT FIREWALL, so proxies for Terminal and git are set automatically.
You can safely modify or remove the alias `proxy` in `zshrc` and the file `gitproxy`.

## Notable plugins and apps

### Quick Look plugins

A set of [Quick Look](http://en.wikipedia.org/wiki/Quick_Look) plugins for developers are bundled via `brew cask`, they are used to help you quick preview the file without opening it for OS X/macOS.
All of the available plugins are included by default.

### SwitchHosts

[SwitchHosts](https://oldj.github.io/SwitchHosts) is used for helping you to `Switch hosts quickly!`
I just accidentally meet it in recent days, and I used [iHost](https://toolinbox.net/iHosts) before, but it is not so powerful if you don't want to pay for it.
