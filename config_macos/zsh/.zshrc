# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh ]]; then
  source ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh
fi

### Load plugins ###

# Install zinit
ZINIT_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git
[ ! -d $ZINIT_HOME ] && mkdir -p $(dirname $ZINIT_HOME)
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
source ${ZINIT_HOME}/zinit.zsh

# Before prompt
zinit light-mode depth=1 for \
    romkatv/powerlevel10k \
  atload"export ZVM_CURSOR_STYLE_ENABLED=false" \
    jeffreytse/zsh-vi-mode \

# After prompt
function zsh_history_bindkeys {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

zinit wait lucid light-mode depth=1 for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"zsh_history_bindkeys" \
    zsh-users/zsh-history-substring-search

### User ###

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# Increasing the limit of open file descriptors for the current shell session
ulimit -n 8096

export EDITOR=nvim

source $HOME/.private

# Homebrew
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# Scripts
export PATH=$HOME/.local/scripts/executables:$PATH

# Pg utils
export PATH=/opt/homebrew/opt/libpq/bin:$PATH

# Go
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.local/share/go/bin:$PATH

export GONOSUMDB=gitea.gospodaprogrammisty.ru
export GOPROXY=https://proxy.golang.org,direct

# Rust
export RUSTUP_HOME=$HOME/.local/share/rust/rustup
export CARGO_HOME=$HOME/.local/share/rust/cargo
export PATH=$CARGO_HOME/bin:$PATH
export RUST_BACKTRACE=1

# .NET
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Node
export NVM_DIR=$HOME/.nvm

# Bat
# export manpager="sh -c 'col -bx | bat -l man -p'"

# Aliases
alias ls="ls -lh --color"
alias v="nvim"
alias n="nnn"
alias py="python3"
alias artisan="php artisan"

alias macfixpostgres14="rm -rf /usr/local/var/postgresql@14/postmaster.pid"

### Loads ###

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/rat/.docker/completions $fpath)
autoload -Uz compinit
compinit

# Kafka completion - doen't work - fix later
# source <(kafkactl completion zsh)

# This loads nvm
[ -s $HOMEBREW_PREFIX/opt/nvm/nvm.sh ] && \. $HOMEBREW_PREFIX/opt/nvm/nvm.sh
# This loads nvm bash_completion
[ -s $HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm ] && \. $HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
