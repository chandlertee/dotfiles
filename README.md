# Dotfiles Installation Guide

This repository contains configuration files and installation scripts to set up my development environment.

## Installation Steps

1. **Clone this repository**:
    ```sh
    git clone https://github.com/chandlertee/dotfiles.git ~/.dotfiles
    ```

2. **Run the installation script**:
    ```sh
    cd ~/.dotfiles/install
    ./install.sh
    ```

3. **Apply macOS settings**:
    ```sh
    ./macos-settings.sh
    ```

## Common Practices

- **Backup existing dotfiles**: Before running the installation script, it's a good idea to back up any existing dotfiles to avoid losing any custom configurations.
- **Review scripts**: Always review the scripts (`install.sh` and `macos-settings.sh`) to understand what changes they will make to your system.
- **Customization**: Feel free to customize the dotfiles and scripts to suit your personal preferences and workflow.

By following these steps, you can quickly set up a consistent development environment across multiple machines.
