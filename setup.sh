#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
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
  ln -s $repo_dir/$1 $target_dir/$2
  echo "${green}done${reset}"
}

create_dotfile () {
  echo "${bold}$1${reset}"
  backup_if_exists $2
  create_symlink $1 $2
}

install_vim_plug() {
  echo "Installing vim-plug..."
  if [ -e ~/.vim/autoload/plug.vim ]
  then
    echo "${yellow}warning: already exists${reset}"
  else
    $(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
    echo "${green}done${reset}"
  fi
}

install_vim_plug_plugins() {
  echo -n "Installing vim-plug plugins..."
  $(vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa")
  echo "${green}done${reset}"
}

create_dotfile "vimrc" ".vimrc"
create_dotfile "vim" ".vim"

echo
install_vim_plug
echo
install_vim_plug_plugins
