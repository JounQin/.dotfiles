# check brew installation
if [ ! -x "$(command -v brew)" ]; then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# oh-my-zsh start
export ZSH=$HOME/.oh-my-zsh
export ZSH_CACHE_DIR=$ZSH/cache

## check Oh-My-Zsh installation
if [ ! -d "$ZSH" ]; then
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

ZSH_THEME="apple"

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

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zplug/zplug", hook-build:"zplug --self-manage"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
# zplug end

# command-not-found
if brew command command-not-found-init > /dev/null 2>&1;
  then eval "$(brew command-not-found-init)";
fi

# aliases
alias flush_dns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias proxy="export all_proxy=socks5://127.0.0.1:1086"
alias unproxy="unset all_proxy"

# exports
export EDITOR=code
