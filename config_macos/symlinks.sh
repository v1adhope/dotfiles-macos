#!/bin/bash

root_path=$HOME/.local/dotfiles-macos/config_macos
config_path=$HOME/.config
local_path=$HOME/.local

CONFIGS=(alacritty tmux nvim mpv bat git nnn zed)

function link_configs {
  for config in ${CONFIGS[@]}; do
    ln -sf $root_path/$config $config_path
  done

  ln -sf $root_path/zsh/.zshrc $HOME
  ln -sf $root_path/ideavimrc/.ideavimrc $HOME
  ln -sf $root_path/scripts $local_path
}

function unlink_configs {
  for config in ${CONFIGS[@]}; do
    unlink $config_path/$config
  done

  unlink $HOME/.zshrc
  unlink $HOME/.ideavimrc
  unlink $HOME/.local/scripts
}

# Comment/ uncomment that you need
# link_configs
# unlink_configs
