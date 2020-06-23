# aliases
alias flush_dns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias proxy="export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7891"
alias unproxy="unset https_proxy;unset http_proxy;unset all_proxy"

# bash
if [ -f $HOME/.bashrc ]
then source $HOME/.bashrc
fi

# oh-my-zsh start
export ZSH=$HOME/.oh-my-zsh
export ZSH_CACHE_DIR=$ZSH/cache

plugins=(
  common-aliases
  command-not-found
  copydir
  copyfile
  dash
  docker
  docker-compose
  docker-machine
  dotenv
  emoji
  emotty
  encode64
  extract
  fd
  frontend-search
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
  iterm2
  jira
  jsontools
  kubectl
  magic-enter
  man
  ng
  node
  npm
  npx
  osx
  please
  profiles
  safe-paste
  thefuck
  sudo
  urltools
  vscode
  yarn
  z
  zsh-navigation-tools
  zsh_reload
)

source $ZSH/oh-my-zsh.sh
# oh-my-zsh end

# zplugin start
source $HOME/.zplugin/bin/zplugin.zsh

## theme

### spaceship start
SPACESHIP_PROMPT_ORDER=(
  package
  node
  golang
  docker
  kubecontext
  exec_time
  jobs
  line_sep
  dir
  git
  char
)

SPACESHIP_RPROMPT_ORDER=(
  user
  host
  time
  battery
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_BATTERY_SHOW=always
SPACESHIP_TIME_SHOW=true

zplugin light denysdovhan/spaceship-prompt
### spaceship end

## plugins
zplugin light zdharma/history-search-multi-word
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-history-substring-search
zplugin ice atload"zpcdreplay" atclone'./zplug.zsh'
zplugin light g-plane/zsh-yarn-autocompletions
# zplugin end

# command-not-found
if brew command command-not-found-init > /dev/null 2>&1
then eval $(brew command-not-found-init)
fi

export BREW_PKG=/usr/local/opt

# nvm
export NVM_DIR=$HOME/.nvm
export NVM_HOME=$BREW_PKG/nvm

if [ -s $NVM_HOME/nvm.sh ]
then source $NVM_HOME/nvm.sh
fi

if [ -s $NVM_HOME/etc/bash_completion.d/nvm ]
then source $NVM_HOME/etc/bash_completion.d/nvm
fi

# exports
export EDITOR=code
export EFF_NO_LINK_RULES=true
export HOMEBREW_BUNDLE_NO_LOCK=true
export FLUTTER_HOME=$BREW_PKG/flutter
export GOPATH=$HOME/go
export RUBY_HOME=$BREW_PKG/ruby
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export CPPFLAGS=-I$RUBY_HOME/include
export LDFLAGS=-L$RUBY_HOME/lib
export PKG_CONFIG_PATH=$RUBY_HOME/lib/pkgconfig
export PATH=/usr/local/sbin:$FLUTTER_HOME/bin:$GOPATH/bin:$RUBY_HOME/bin:$PATH

# local
if [ -f $HOME/.zshrc.local ]
then source $HOME/.zshrc.local
fi
