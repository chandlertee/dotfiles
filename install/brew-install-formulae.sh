#!/usr/bin/env bash

# Install Homebrew and packages
if ! brew --version &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle --file ~/.dotfiles/install/Brewfile --verbose

# Symlink configuration files using Stow
if ! command -v stow &>/dev/null; then
    brew install stow
fi
