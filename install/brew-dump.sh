#!/usr/bin/env bash

# Dump formulas and taps with descriptions
brew bundle dump --formula --tap --describe --force --file=~/.dotfiles/install/Brewfile
# Dump casks with descriptions
brew bundle dump --cask --mas --vscode --describe --force --file=~/.dotfiles/install/Caskfile
