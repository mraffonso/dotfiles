"             __                            
"     __  __ /\_\    ___ ___   _ __   ___   
"    /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\ 
"  __\ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/ 
" /\_\\ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
" \/_/ \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/ 
"

" Use Vim settings instead of strict Vi compatible settings
" This must be set first, since it changes other options.
set nocompatible

" ================= General Configuration =================

set number " Line numbers are good
set backspace=indent,eol,start " Allow backspace in insert mode
set history=1000 " Store lots of :cmdline history
set showcmd " Show incomplete cmds down the bottom
set showmode " Show current mode down the bottom
set gcr=a:blinkon0 " Disable cursor blink
set visualbell " No sounds
set autoread " Reload files changed outside vim
set nohidden " Close buffers immediately
set mouse=a " Mouse support in console
set fileformat=unix " Ditch the dirty CRLF

" Turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away.
" This has to be set before vundle
let mapleader=","

" ================= Vundle Initialization =================

" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

" ====================== Swap Files =======================

" Enable swapfiles and set path
silent !mkdir -p ~/.vim/tmp > /dev/null 2>&1
set swapfile
set backupdir=~/.vim/tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/tmp,/var/tmp,/tmp

" ==================== Persistent Undo ====================

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ====================== Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap " Don't wrap lines
set linebreak "Wrap lines at convenient points

" ========================= Folds =========================

set foldmethod=indent " Fold based on indent
set foldnestmax=3 " Deepest fold is 3 levels
set nofoldenable " Dont fold by default

" ======================= Completion ======================

set wildmode=list:longest,full
set wildmenu " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ======================= Scrolling =======================

set scrolloff=8 " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ======================= Searching =======================

set ignorecase " Case insensitive search
set smartcase " Unless uppercase is used
set incsearch " Incremental search
set hlsearch " Highlight matching text

" ======================== Copying ========================

let g:clipbrdDefaultReg = '+' " Since I use linux, I want this
vmap <C-c> "+y " Copy selected text with CTRL+c

" ======================== Mapping ========================

" Remap jj to escape in insert mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" ======================= Statusbar =======================

set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" ================ Post Setup Instructions ================

" After a fresh setup with this vim config you should do the following.

" Add helptags for ctrlp
" :helptags ~/.vim/bundle/ctrlp.vim/doc

" Create ctags for OmniCppComplete
" cd ~/.vim/tags
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ C:\MinGW\include
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ C:\MinGW\lib\gcc\mingw32\4.8.1\include

