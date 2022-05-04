# Fig pre block. Keep at the top of this file.
if [ -d "$HOME/.fig" ]; then
  source "$HOME/.fig/shell/zshrc.pre.zsh"
fi

# aliases
alias flush_dns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias proxy="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias unproxy="unset https_proxy http_proxy all_proxy"

# oh-my-zsh start
export ZSH=$HOME/.oh-my-zsh
export ZSH_CACHE_DIR=$ZSH/cache
export ZSH_DISABLE_COMPFIX=true

plugins=(
  common-aliases
  command-not-found
  copyfile
  copypath
  dash
  docker
  docker-compose
  docker-machine
  emoji
  emotty
  encode64
  extract
  fd
  frontend-search
  gh
  git
  git-auto-fetch
  git-extras
  git-flow
  git-hubflow
  git-prompt
  gitfast
  github
  gitignore
  golang
  history
  history-substring-search
  iterm2
  jira
  jsontools
  kube-ps1
  kubectl
  macos
  magic-enter
  man
  ng
  node
  npm
  please
  profiles
  ruby
  safe-paste
  thefuck
  sudo
  urltools
  vscode
  yarn
  z
  zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh
# oh-my-zsh end

# zinit start
source $HOME/.local/share/zinit/zinit.git/zinit.zsh

## theme
eval "$(starship init zsh)"

## plugins
zinit light zdharma-continuum/history-search-multi-word
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit ice atload"zpcdreplay" atclone'./zplug.zsh' atpull"%atclone"
zinit light g-plane/zsh-yarn-autocompletions
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust
# zinit end

# command-not-found
if brew command command-not-found-init > /dev/null 2>&1; then
  eval $(brew command-not-found-init)
fi

export BREW_PKG=$(brew --prefix)/opt

# nvm
export NVM_DIR=$HOME/.nvm
export NVM_HOME=$BREW_PKG/nvm

if [ -s $NVM_HOME/nvm.sh ]; then
  source $NVM_HOME/nvm.sh
fi

if [ -s $NVM_HOME/etc/bash_completion.d/nvm ]; then
  source $NVM_HOME/etc/bash_completion.d/nvm
fi

# rust
if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi

# exports
export EDITOR=code
export EFF_NO_LINK_RULES=true
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export HOMEBREW_BUNDLE_NO_LOCK=true
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export STARSHIP_CONFIG=~/.starship/config.toml
export DENO_HOME=$HOME/.deno
export GOPATH=$HOME/go
export KREW_ROOT=$HOME/.krew
export KUBECONFIG=$HOME/.kube/config
export RUBY_HOME=$BREW_PKG/ruby
export CPPFLAGS=-I$RUBY_HOME/include
export LDFLAGS=-L$RUBY_HOME/lib
export PKG_CONFIG_PATH=$RUBY_HOME/lib/pkgconfig
export PATH=/usr/local/sbin:$DENO_HOME/bin:$GOPATH/bin:$KREW_ROOT/bin:$RUBY_HOME/bin:$PATH

# bash
if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi

# local
if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

# Fig post block. Keep at the bottom of this file.
if [ -d "$HOME/.fig" ]; then
  source "$HOME/.fig/shell/zshrc.post.zsh"
fi
