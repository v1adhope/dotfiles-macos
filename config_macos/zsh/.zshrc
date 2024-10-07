# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Load plugins
#
# Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
#
# Before prompt
zinit light-mode depth=1 for \
    romkatv/powerlevel10k \
  atload"export ZVM_CURSOR_STYLE_ENABLED=false" \
    jeffreytse/zsh-vi-mode \
#
# After prompt
function zsh_history_bindkeys {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}
#
zinit wait lucid light-mode depth=1 for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"zsh_history_bindkeys" \
    zsh-users/zsh-history-substring-search

### Exports
#
source $HOME/.local/scripts/alias.sh
# TODO: source $HOME/.private
#
# Runnable scripts
export PATH=$HOME/.local/scripts/executables:$PATH
#
# Homebrew
export PATH=/usr/local/sbin:$PATH
export HOMEBREW_NO_ANALYTICS=1
#
# Customize nnn
source "$HOME/.config/nnn/customize.sh"
#
# Go
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.local/share/go/bin:$PATH
#
# Rust
export RUSTUP_HOME=$HOME/.local/share/rust/rustup
export CARGO_HOME=$HOME/.local/share/rust/cargo
source $HOME/.local/share/rust/cargo/env
export RUST_BACKTRACE=1
#
# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# Bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#
# Editor
export EDITOR=nvim

### Loads
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
