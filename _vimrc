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

" Set encoding to utf-8 for use of special characters in this file
set encoding=utf-8
scriptencoding utf-8


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

" Crontab fix, don't use writebackup when editing crontab files.
autocmd filetype crontab setlocal nobackup nowritebackup


" ================= Vundle Initialization =================

" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif


" ================= Swap, Backps & Viminfo ================

" Enable swapfiles and set path
silent !mkdir -p ~/.vim/tmp > /dev/null 2>&1
set swapfile
set backupdir=~/.vim/tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/tmp,/var/tmp,/tmp

if has('nvim')
  set viminfo+=n~/.vim/nviminfo
else
  set viminfo+=n~/.vim/viminfo
endif


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


"==================== Custom Functions ====================

" Search and count occurences
function SearchAndCountOccurences(pattern)
  execute '/' . a:pattern
  execute ':%s///gn'
endfunction

" Displays the status of search highlighting
function HlsearchStatus()
  if &hlsearch
    return 'Search highlighting enabled'
  else
    return 'Search highlighting disabled'
  endif
endfunction

" Toggles search highlighting on and off
function ToggleHlsearch()
  if &hlsearch
    set nohlsearch
  else
    set hlsearch
  endif
endfunction


"==================== Custom Commands =====================

" Count Occurences of previous search
" command CountOccurences :%s///gn
" command -nargs=1 CountOccurences /<f-args><bar>:%s///gn
command -nargs=1 CountOccurences :call SearchAndCountOccurences(<f-args>)


" ======================== Mapping ========================

" Remap jj to escape in insert mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>
inoremap JJ <ESC>
nnoremap JJJJ <Nop>

" Setup toggling search highlighting
nnoremap <silent> <C-l> :call ToggleHlsearch()<CR><C-l>:echo HlsearchStatus()<CR>

" Remap a to A in command mode
noremap a A

" Use Tab and S-Tab to switch between buffers
nnoremap  <silent>   <Tab>  :bnext<CR>
nnoremap  <silent> <S-Tab>  :bprevious<CR>


" ======================= Statusbar =======================

set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]


" ================ Post Setup Instructions ================

" After a fresh setup with this vim config you should do the following.

" Install vundle and plugins
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim +PluginInstall +qall

" Add helptags for ctrlp
" vim -c "helptags ~/.vim/bundle/ctrlp.vim/doc" -qall

" Create tags for OmniCppComplete
"
" Linux
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f ~/.vim/tags/cpp /usr/include/c++
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f ~/.vim/tags/gl /usr/include/GL
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f ~/.vim/tags/qt4 /usr/include/qt4
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f ~/.vim/tags/sdl /usr/include/sdl
"
" macOS
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f ~/.vim/ctags/cpp /Library/Developer/CommandLineTools/usr/include/c++
"
" Windows
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f "%USERPROFILE%\.vim\tags\cpp" C:\MinGW\lib\gcc\mingw32\4.8.1\include\c++
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f "%USERPROFILE%\.vim\tags\sfml" C:\SFML-2.1\include\SFML
