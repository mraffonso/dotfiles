#!/bin/sh

# setup.sh -- Dotfile setup manager

CWD=$(pwd)

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
  echo "all          -- Meta: Install all Linux packages"
  echo "osx          -- Meta: Install all OS X packages"
  echo "win          -- Meta: Install all Windows packages"
  echo
  echo "git          -- Pkg:  Symlink Git configs"
  echo "hg           -- Pkg:  Install Mercurial config"
  echo "nvim         -- Pkg:  Install NeoVim config"
  echo "oh-my-zsh    -- Pkg:  Symlink OMZ and ZSH config"
  echo "rails        -- Pkg:  Symlink Rails config"
  echo "ruby-gems    -- Pkg:  Symlink Ruby Gems config"
  echo "subl         -- Pkg:  Install Sublime Text 3 config"
  echo "tmux         -- Pkg:  Install tmux config"
  echo "vim          -- Pkg:  Install vim config"
  echo "win-bin      -- Pkg:  Install custom Windows scripts"
  echo "win-git-bash -- Pkg:  Install Git Bash config for Windows"
  echo "win-subl     -- Pkg:  Install Sublime Text 3 config"
  echo "osx-bin      -- Pkg:  Symlink bin directory"
}

ask_yes_no() {
  read -r -p "$1 [y/N] " response
  case $response in
    [yY][eE][sS]|[yY])
      return 0
      ;;
    *)
      return 1
    ;;
  esac
}

file_exists() {
  if [ -f $1 ]; then
    return 0
  else
    return 1
  fi
}

dir_exists() {
  if [ -d "$1" ]; then
    return 0
  else
    return 1
  fi
}

symlink_exists() {
  if [ -L $1 ]; then
    return 0
  else
    return 1
  fi
}

install_file() {
  # $1 = filename, $2 = target
  if [ $# -eq 2 ]; then
    if file_exists "$CWD/$1"; then
      base=`dirname "$HOME/$2"`
      # file has a base, ensure it's created
      if [ "$base" != "." ]; then
        mkdir -p "$base"
      fi
      echo "Install file: $2"
      cp "$CWD/$1" "$HOME/$2"
    else
      echo "*skipping: $1"
    fi
  else
    echo "install_file() requires 2 parameters (filename, target)"
    exit 1
  fi
}

install_dir() {
  # $1 = dirname, $2 = target
  if [ $# -eq 2 ]; then
    if dir_exists "$CWD/$1"; then
      if dir_exists "$HOME/$2"; then
        echo "Update dir: $2"
        cp -R "$CWD/$1/." "$HOME/$2/"
      else
        echo Install dir: $2
        cp -R "$CWD/$1" "$HOME/$2"
      fi
    fi
  else
    echo "install_dir() requires 2 parameters (dirname, target)"
  fi
}

create_symlink() {
  # $1 = filename, $2 = target
  if [ $# -eq 2 ]; then
    if symlink_exists "$HOME/$2"; then
      echo "Symlink exists **skipping: $1"
    else
      echo "Creating symlink $2 -> $1"
      ln -s "$CWD/$1" "$HOME/$2"
    fi
  else
    echo "create_symlink() requires 2 parameters (filename, target)"
    exit 1
  fi
}

bin() {
  echo "-- bin --"
  create_symlink "bin" "bin"
  echo
}

git() {
  echo "-- git --"
  create_symlink "_gitconfig" ".gitconfig"
  create_symlink "_gitignore_global" ".gitignore_global"
  echo
}

hg() {
  echo "-- hg --"
  install_file "_hgrc" ".hgrc"
  echo
}

nvim() {
  echo "-- neovim --"
  mkdir -p $HOME/.config/nvim
  create_symlink "_vimrc" ".config/nvim/init.vim"
  echo
}

oh_my_zsh() {
  echo "-- oh-my-zsh --"
  create_symlink "_oh-my-zsh/custom/plugins/mario" ".oh-my-zsh/custom/plugins/mario"
  create_symlink "_zshrc" ".zshrc"
  echo
}

rails() {
  echo "--rails--"
  create_symlink "_railsrc" ".railsrc"
  echo
}

ruby_gems() {
  echo "-- ruby gems --"
  create_symlink "_gemrc" ".gemrc"
  echo
}

subl() {
  echo "-- subl --"
  install_dir "_config/sublime-text-3" ".config/sublime-text-3"
  echo
}

tmux() {
  echo "-- tmux --"
  create_symlink "_tmux/tmux.conf" ".tmux.conf"
  echo
}

vim() {
  echo "-- vim --"
  create_symlink "_vimrc" ".vimrc"
  create_symlink "_vim" ".vim"
  echo
  if ask_yes_no "Do you want to run vim bootstrap?"; then
    $HOME/.vim/setup/bootstrap.sh
  else
    echo "Please run ~/.vim/setup/bootstrap.sh manually."
  fi
  echo
}

win_bin() {
  echo "-- win-bin --"
  create_symlink "win_bin" "bin"
  echo
}

win_git_bash() {
  echo "-- win git bash --"
  create_symlink "win_bashrc" ".bashrc"
  echo
}

win_subl() {
  echo "-- win subl --"
  install_dir "_config/sublime-text-3" "AppData/Roaming/Sublime Text 3"
  echo
}

all() {
  bin
  git
  hg
  nvim
  oh_my_zsh
  rails
  ruby_gems
  subl
  tmux
  vim
}

osx_bin() {
  echo "-- win bin --"
  create_symlink "osx_bin" "bin"
  echo
}

osx () {
  osx_bin
}

win() {
  win_bin
  win_git_bash
  win_subl
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
    "osx")
      osx
      exit 0
    ;;
    "win")
      win
      exit 0
    ;;
    "bin")
      bin
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
    "nvim")
      nvim
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
    "subl")
      subl
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
    "osx-bin")
      osx_bin
      exit 0
    ;;
    "win-bin")
      win_bin
      exit 0
    ;;
    "win-git-bash")
      win_git_bash
      exit 0
    ;;
    "win-subl")
      win_subl
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
