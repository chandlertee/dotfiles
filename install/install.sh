#!/usr/bin/env bash

# Install Homebrew and packages
"$(dirname "$0")/brew-install-formulae.sh"
# Symlink configuration files using Stow
"$(dirname "$0")/stow-create-symlinks.sh"
# Install software managed by brews, e.g., Pyenv -> Python, Chruby -> Ruby
"$(dirname "$0")/brew-install-managed.sh"
# Install Homebrew Casks
"$(dirname "$0")/brew-install-casks.sh"
