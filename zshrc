# zplug start
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
## reference: https://github.com/zplug/zplug

## Use the package as a command
## And accept glob patterns (e.g., brace, wildcard, ...)
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

## Supports oh-my-zsh plugins and the like
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/dash", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/git-flow", from:oh-my-zsh
zplug "plugins/gitignore", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/iterm2", from:oh-my-zsh
zplug "plugins/jira", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/ng", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/safe-paste", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh
zplug "plugins/vscode", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh

## Load theme file
zplug 'themes/apple', from:oh-my-zsh, as:theme

## Let zplug manage zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

## Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

## Then, source plugins and add commands to $PATH
zplug load
# zplug end

#command-not-found
if brew command command-not-found-init > /dev/null 2>&1;
  then eval "$(brew command-not-found-init)";
fi

# proxy list
alias proxy='export all_proxy=socks5://127.0.0.1:1086'
alias unproxy='unset all_proxy'
