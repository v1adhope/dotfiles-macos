#!/usr/bin/env bash

# Prepare nix-darwin flakes and use config from nix-darwin directive. See https://github.com/LnL7/nix-darwin
function first_run {
  softwareupdate --install-rosetta
  xcode-select --install
}

function post_nix-darwin_run {
  rustup default stable
}

root_path="$HOME/.local/dotfiles-macos/config_macos"
config_path="$HOME/.config"
local_path="$HOME/.local"

CONFIGS=(alacritty tmux nvim mpv bat git nnn zed aerospace golangci-lint)

function link_configs {
  ln -sf "$root_path/zsh/.zshrc" "$HOME"
  ln -sf "$root_path/ideavimrc/.ideavimrc" "$HOME"
  ln -sf "$root_path/scripts" "$local_path"

  for config in "${CONFIGS[@]}"; do
    ln -sf "$root_path/$config" "$config_path"
  done
}

function unlink_configs {
  unlink "$HOME/.zshrc"
  unlink "$HOME/.ideavimrc"
  unlink "$HOME/.local/scripts"

  for config in "${CONFIGS[@]}"; do
    unlink "$config_path/$config"
  done
}

# Comment/ uncomment that you need
# first_run
# link_configs
# unlink_configs
# post_nix-darwin_run

ln -sf "$root_path/cargo/config.toml" "$HOME/.local/share/rust/cargo/config.toml"
