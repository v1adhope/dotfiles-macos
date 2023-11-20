#!/bin/zsh

echo "=> run brew upgrade..."
brew upgrade || exit 1

echo "=> run brew autoremove..."
brew autoremove || exit 1

echo "=> run brew cleanup..."
brew cleanup || exit 1

echo "=> run brew doctor..."
brew doctor || exit 1

echo "=> run app store apps update (mas)"
mas upgrade || exit 1

# echo "=> run software update..."
# softwareupdate -ia
