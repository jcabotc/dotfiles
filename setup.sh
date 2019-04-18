#!/bin/bash

green=$(tput setaf 2)
bold=$(tput bold)
reset=$(tput sgr0)

repo_dir=$(pwd)
target_dir=$HOME
files=".vimrc .vim"

date=$(date +%Y%m%d_%H%M%S)

backup_if_exists () {
  path=$target_dir/$1

  if [ -e $path ]
  then
    backup_file_name=$1_old_$date
    backup_path=$target_dir/$backup_file_name

    echo -n " ├─ Creating backup ($backup_file_name)..."
    mv $path $backup_path
    echo "${green}done${reset}"
  fi
}

create_symlink () {
  echo -n " └─ Creating symlink..."
  ln -s $repo_dir/$1 $target_dir/$1
  echo "${green}done${reset}"
}

# Create symlinks to dotfiles

for file in $files; do
	echo "${bold}$file${reset}"
  backup_if_exists $file
  create_symlink $file
done
