"        __         
" ___  _|__| _____  
" \  \/ /  |/     \ 
"  \   /|  |  Y Y  \
"   \_/ |__|__|_|  /
"                \/ 

" Necesary for lots of cool vim things
set nocompatible

"
" PLUGINS
"

" Vundle
"
" Steps:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Vim: :PluginInstall
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ctrlp.vim
"
" Vim: :helptags ~/.vim/bundle/ctrlp.vim/doc
Plugin 'kien/ctrlp.vim'
set runtimepath^=~/.vim/bundle/ctrlp.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"
" VIM CONFIG
"

" Set color scheme
"colorscheme metacosm

" Enable syntax highlighting
syntax on

" Shows what you are typing as a command
set showcmd

" Disable beeping
set visualbell

" Set tabs to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Enable auto-indent
set autoindent

" Enable tab completion
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Enable line numbers
set number

" Enable case insensitive search unless uppercase is used
set ignorecase
set smartcase

" Remap jj to escape in insert mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Enable incremental search, and highlight matching text
set incsearch
set hlsearch

" Remove the buffer when tabs are closed
set nohidden

" Improved statusbar
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Enable swapfiles and set path
"
" Steps:
" mkdir -p ~/tmp
set swapfile
set dir=~/tmp

" To disable backups use
" set nobackup
