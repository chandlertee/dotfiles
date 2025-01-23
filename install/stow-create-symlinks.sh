#!/usr/bin/env bash

warning="\033[33m"
normal="\033[0m"
success="\033[32m"

# Try stow first
if ! stow . 2>/dev/null; then

    echo -e ${warning}
    echo -e "Stow encountered conflicts. Backing up existing files..."
    
    # Get conflicts from stow's dry-run
    conflicts=$(stow --no -v . 2>&1 | grep "existing target" | sed 's/.*over existing target \(.*\) since.*/\1/')

    if [ -n "$conflicts" ]; then
        echo -e "${warning}The following files will be backed up:${normal}"
        echo -e "${warning}$conflicts${normal}"
        read -ep "Do you want to proceed with backup? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${normal}Proceeding with backup with ${conflicts//[$'\t\r\n']/, }"
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
        echo -e "${success}Stow successful. Symlinks created.${normal}"

    else
        echo -e "${warning}Stow failed. Please resolve conflicts manually.${normal}"
    fi
else
    echo -e "${success}Stow successful. Symlinks created.${normal}"
fi

# After symlinks are created, source .zshrc
source ~/.zshrc
