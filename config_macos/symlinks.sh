#!/bin/bash

### Comment/ uncomment that you need
#
config_path=$HOME/.config
local_path=$HOME/.local

ln -sf $HOME/.local/dotfiles/config_macos/zsh/.zshrc $HOME
# unlink $HOME/.zshrc

ln -sf $HOME/.local/dotfiles/config_macos/alacritty $config_path
# unlink $HOME/.config/alacritty

ln -sf $HOME/.local/dotfiles/config_macos/tmux $config_path
# unlink $HOME/.config/tmux

ln -sf $HOME/.local/dotfiles/config_macos/nvim $config_path
# unlink $HOME/.config/nvim

ln -sf $HOME/.local/dotfiles/config_macos/mpv $config_path
# unlink $HOME/.config/mpv

ln -sf $HOME/.local/dotfiles/config_macos/scripts $local_path
# unlink $HOME/.local/scripts
