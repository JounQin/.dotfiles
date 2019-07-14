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

# zplug start
export ZPLUG_HOME=/usr/local/opt/zplug

source $ZPLUG_HOME/init.zsh

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

zplug denysdovhan/spaceship-prompt, as:theme
### spaceship end

## plugins
zplug zdharma/fast-syntax-highlighting
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-history-substring-search

## manage zplug itself
zplug zplug/zplug, hook-build:"zplug --self-manage"

if ! zplug check --verbose
then
  printf "Install? [y/N]: "
  if read -q
  then
    echo
    zplug install
  fi
fi

zplug load
# zplug end

# command-not-found
if brew command command-not-found-init > /dev/null 2>&1
then eval "$(brew command-not-found-init)"
fi

# aliases
alias flush_dns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias proxy="export https_proxy=http://127.0.0.1:1087;export http_proxy=http://127.0.0.1:1087;export all_proxy=socks5://127.0.0.1:1086"
alias unproxy="unset https_proxy;unset http_proxy;unset all_proxy"

## proxy by default
if [ "true" != "$CI" ]
then proxy
fi

# exports
export PATH="/usr/local/sbin:$PATH"
export EDITOR=code
