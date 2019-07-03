# oh-my-zsh start
export ZSH=$HOME/.oh-my-zsh
export ZSH_CACHE_DIR=$ZSH/cache

ZSH_THEME="apple"

plugins=(
          common-aliases
          command-not-found
          copydir
          copyfile
          dash
          docker
          docker-compose
          emoji
          git
          gitfast
          git-flow
          gitignore
          golang
          history
          iterm2
          jira
          kubectl
          ng
          node
          npm
          osx
          safe-paste
          sudo
          thefuck
          vscode
          yarn
          z
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

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
# zplug end

#command-not-found
if brew command command-not-found-init > /dev/null 2>&1;
  then eval "$(brew command-not-found-init)";
fi

# proxy list
alias proxy='export all_proxy=socks5://127.0.0.1:1086'
alias unproxy='unset all_proxy'
