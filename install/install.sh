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

# Try stow first
if ! stow . 2>/dev/null; then
    warning="\033[33m"
    normal="\033[0m"
    echo ${warning}
    echo "Stow encountered conflicts. Backing up existing files..."
    
    # Get conflicts from stow's dry-run
    conflicts=$(stow --no -v . 2>&1 | grep "existing target" | sed 's/.*over existing target \(.*\) since.*/\1/')

    if [ -n "$conflicts" ]; then
        echo "${warning}The following files will be backed up:"
        echo "${warning}$conflicts"
        read -ep "Do you want to proceed with backup? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "${normal}Proceeding with backup with ${conflicts//[$'\t\r\n']/, }"
            while IFS= read -r file; do
                target="${HOME}/${file}"
                echo $target
                if [ -f "$target" ] && [ ! -L "$target" ]; then
                    echo "Backing up: $target -> $target.bak"
                    mv "$target" "$target.bak"
                fi
            done <<< "$conflicts"
        else
            echo "Backup cancelled"
            exit 1
        fi
    fi
    
    echo "Retrying stow..."
    if stow . 2>/dev/null; then
        success="\033[32m"
        echo "${success}Stow successful. Symlinks created.${normal}"

    else
        echo "${warning}Stow failed. Please resolve conflicts manually."
    fi
fi

# After symlinks are created, source .zshrc
source ~/.zshrc

# If pyenv is installed, install Python
if command -v pyenv &>/dev/null; then
    if [ -f ~/.pyenv/version ]; then
        desired_python=$(cat ~/.pyenv/version)
        if ! pyenv versions | grep -q "$desired_python"; then
            echo "Installing Python version from .pyenv/version: $desired_python"
            pyenv install "$desired_python"
            pyenv global "$desired_python"
        fi
    else
        latest_python=$(pyenv install --list | grep -v '[a-zA-Z]' | grep -v - | tail -1 | tr -d '[:space:]')
        if ! pyenv versions | grep -q "$latest_python"; then
            echo "Installing latest Python version: $latest_python"
            pyenv install "$latest_python"
            pyenv global "$latest_python"
        fi
    fi
    echo "Using $(python --version)"
fi
