" must come first
set nocompatible

syntax enable
filetype plugin indent on

set showcmd 
set showmode

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set visualbell                    " No beeping.

set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set laststatus=2                  " Show the status line all the time

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Use the vividchalk color scheme from tpope (https://github.com/tpope/vim-vividchalk)
colorscheme vividchalk

" Vim Tag List 
nnoremap <silent> <F8> :TlistToggle<CR>

" size of a hard tabstop
set tabstop=2

" size of an "indent"
set shiftwidth=2

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

set swapfile
set dir=~/tmp
