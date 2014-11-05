#!/bin/sh

# setup.sh -- Dotfile setup manager

CWD=$(pwd)
INSTDIR=$HOME

show_help() {
  if [ $# -eq 1 ]; then
    echo $1
    echo
  fi
  echo "setup.sh - Dotfile setup manager"
  echo
  echo "Usage: setup.sh {package}"
  echo
  echo "Packages:"
  echo "all"
  echo "git"
  echo "hg"
  echo "oh-my-zsh"
  echo "rails"
  echo "ruby-gems"
  echo "tmux"
  echo "vim"
  echo
}

file_exists() {
  if [ -f $1 ]; then
    return 0
  else
    return 1
  fi
}

dir_exists() {
  if [ -d $1 ]; then
    return 0
  else
    return 1
  fi
}

install_file() {
  # $1 = filename, $2 = target
  if [ $# -eq 2 ]; then
    if file_exists "$CWD/$1"; then
      base=`dirname $2`
      # file has a base, ensure it's created
      if [ "$base" != "." ]; then
        mkdir -p "$base"
      fi
      echo "Install file: $2"
      cp "$CWD/$1" "$INSTDIR/$2"
    else
      echo "*skipping: $1"
    fi
  else
    echo "install_file() requires 2 parameters (filename, target)"
  fi
}

install_dir() {
  # $1 = dirname, $2 = target
  if [ $# -eq 2 ]; then
    if dir_exists "$CWD/$1"; then
      if dir_exists "$INSTDIR/$2"; then
        echo "Update dir: $2"
        cp -R "$CWD/$1/." "$INSTDIR/$2/"
      else
        echo Install dir: $2
        cp -R "$CWD/$1" "$INSTDIR/$2"
      fi
    fi
  else
    echo "install_dir() requires 2 parameters (dirname, target)"
  fi
}

git() {
  echo "-- git --"
  install_file "gitconfig" ".gitconfig"
  echo
}

hg() {
  echo "-- hg --"
  install_file "hgrc" ".hgrc"
  echo
}

oh_my_zsh() {
  echo "-- oh-my-zsh --"
  install_dir "oh-my-zsh" ".oh-my-zsh"
  echo
}

rails() {
  echo "--rails--"
  install_file "railsrc" ".railsrc"
  echo
}

ruby_gems() {
  echo "-- ruby gems --"
  install_file "gemrc" ".gemrc"
  echo
}

tmux() {
  echo "-- tmux --"
  install_file "tmux.conf" ".tmux.conf"
  echo
}

vim() {
  echo "-- vim --"
  install_file "vimrc" ".vimrc"
  install_dir "vim" ".vim"
  echo
}

all() {
  git
  hg
  oh_my_zsh
  rails
  ruby_gems
  tmux
  vim
}

if [ $# -lt 1 ]; then
  show_help "Error: Invalid syntax!"
  exit 1
elif [ $# -eq 1 ]; then
  case "$1" in
    "all")
      all
      exit 0
    ;;
    "git")
      git
      exit 0
    ;;
    "hg")
      hg
      exit 0
    ;;
    "oh-my-zsh")
      oh_my_zsh
      exit 0
    ;;
    "rails")
      rails
      exit 0
    ;;
    "ruby-gems")
      ruby_gems
      exit 0
    ;;
    "tmux")
      tmux
      exit 0
    ;;
    "vim")
      vim
      exit 0
    ;;
    *)
      show_help "Error: Unknown command!"
      exit 1
    ;;
  esac
elif [ $# -gt 1 ]; then
  show_help "Error: Invalid syntax!"
  exit 1
fi

