#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Set up files and directories
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc gitconfig vim zshrc gitignore tmux.conf gvimrc tmuxinator"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -e "📁  Creating ${BLUE}$olddir${NC} for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo -e "✅  ${GREEN}...done${NC}"


# change to the dotfiles directory
echo -e "Changing to the ${BLUE}$dir${NC} directory"
cd $dir
echo -e "✅  ${GREEN}...done${NC}"

echo -e "\n🚨  ${YELLOW}Begin linking${NC} 🚨 \n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo -e "📄  ${RED}$file${NC}"
    echo "Moving $file from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
