# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

if ! command_exists brew; then
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# aliases
alias flush_dns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias nvm=fnm
alias proxy="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias unproxy="unset https_proxy http_proxy all_proxy"

# oh-my-zsh start
export ZSH=$HOME/.oh-my-zsh
export ZSH_CACHE_DIR=$ZSH/cache
export ZSH_DISABLE_COMPFIX=true

DISABLE_UNTRACKED_FILES_DIRTY=true
ENABLE_CORRECTION=true
HYPHEN_INSENSITIVE=true

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
  heroku
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
zinit light b4b4r07/emoji-cli
# zinit light b4b4r07/enhancd
zinit light chrissicool/zsh-256color
zinit light MichaelAquilina/zsh-you-should-use
zinit light ntnyq/omz-plugin-pnpm
zinit light paulirish/git-open
zinit light zdharma-continuum/history-search-multi-word
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
# zinit end

# bun
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi

# command-not-found
if brew command command-not-found-init > /dev/null 2>&1; then
  eval $(brew command-not-found-init)
fi

export BREW_PKG=$(brew --prefix)/opt

# fnm
export FNM_HOME=$BREW_PKG/fnm

if [ -s $FNM_HOME/etc/bash_completion.d/fnm ]; then
  source $FNM_HOME/etc/bash_completion.d/fnm
fi

eval "$(fnm env --use-on-cd)"

# rust
if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi

# bun completions
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vim
else
  export EDITOR=code
fi

# exports
export EFF_NO_LINK_RULES=true
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export HOMEBREW_BUNDLE_NO_LOCK=true
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export STARSHIP_CONFIG=$HOME/.starship/config.toml
export BUN_INSTALL=$HOME/.bun
export DENO_HOME=$HOME/.deno
export GOPATH=$HOME/go
export GOROOT=$(go env GOROOT)
export HOMEBREW_TEMP=$HOME/.tmp
export KREW_ROOT=$HOME/.krew
export KUBECONFIG=$HOME/.kube/config
export GLIBC_HOME=$BREW_PKG/glibc
export RUBY_HOME=$BREW_PKG/ruby
export CPPFLAGS="-I$GLIBC_HOME/include -I$RUBY_HOME/include"
export LDFLAGS="-L$GLIBC_HOME/lib -L$RUBY_HOME/lib"
export PKG_CONFIG_PATH=$RUBY_HOME/lib/pkgconfig
export PNPM_HOME=$HOME/Library/pnpm
export TMPDIR=$HOME/.tmp
export PATH=$BUN_INSTALL/bin:$DENO_HOME/bin:$GLIBC_HOME/bin:$GLIBC_HOME/sbin:$GOPATH/bin:$GOROOT/misc/wasm:$KREW_ROOT/bin:$RUBY_HOME/bin:$PNPM_HOME:$PATH

# local
if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
