#!/usr/bin/env bash

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

# If chruby is installed, install Ruby
if command -v chruby &>/dev/null; then
    # Get desired Ruby version from .zshrc
    desired_ruby=$(grep "chruby ruby-" ~/.zshrc | sed 's/.*ruby-\([0-9.]*\).*/\1/')
    if [ -n "$desired_ruby" ]; then
        chruby "ruby-$desired_ruby"
        echo "Using Ruby version from .zshrc: $(ruby --version)"
    else
        latest_ruby=$(chruby | grep -v 'system' | tail -1 | tr -d '[:space:]')
        chruby "$latest_ruby"
        echo "No version found in .zshrc, using latest: $(ruby --version)"
    fi
fi
