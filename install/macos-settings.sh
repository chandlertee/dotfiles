#!/usr/bin/env bash

# Apply macOS settings
if [[ "$OSTYPE" == "darwin"* ]]; then
   # Example macOS settings
   # Automatically hide and show the Dock
   defaults write com.apple.dock autohide -bool false
   # Set Dock tile size
   defaults write com.apple.dock tilesize -int 36
   # Restart Dock to apply changes
   killall Dock
fi
