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

install_vim_vundle() {
  echo "Installing vundle..."
  if [ -e ~/.vim/bundle/Vundle.vim ]
  then
    echo "${yellow}warning: already exists${reset}"
  else
    $(git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim)
    echo "${green}done${reset}"
  fi
}

install_vim_vundle_plugins() {
  echo -n "Installing vundle plugins..."
  $(vim +BundleInstall +qall 2&> /dev/null)
  echo "${green}done${reset}"
}

make_vimproc_plugin () {
  echo "Making vimproc plugin..."
  if [ -e ~/.vim/bundle/vimproc.vim/lib/vimproc_mac.so ]
  then
    echo "${yellow}warning: make already ran for vimproc${reset}"
  else
    cd ~/.vim/bundle/vimproc.vim
    make
    echo "${green}done${reset}"
  fi
}

create_dotfile "vimrc" ".vimrc"
create_dotfile "vim" ".vim"

echo
install_vim_vundle
echo
install_vim_vundle_plugins
echo
make_vimproc_plugin
