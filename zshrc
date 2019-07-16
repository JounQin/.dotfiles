# aliases
alias flush_dns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias proxy="export https_proxy=http://127.0.0.1:1087;export http_proxy=http://127.0.0.1:1087;export all_proxy=socks5://127.0.0.1:1086"
alias unproxy="unset https_proxy;unset http_proxy;unset all_proxy"

## proxy by default
if [ "true" != "$CI" ]
then proxy
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
  git-remote-branch
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

# zplugin end

# command-not-found
if brew command command-not-found-init > /dev/null 2>&1
then eval "$(brew command-not-found-init)"
fi

# exports
export EDITOR=code
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export PATH="/usr/local/sbin:$PATH"
