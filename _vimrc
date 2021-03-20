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
set encoding=utf-8 nobomb " BOM often causes trouble
scriptencoding utf-8 nobomb " BOM often causes trouble

" --- performance / buffer ---
set hidden " to switch current buffer without writing
set lazyredraw " Don't update the display while executing macros
set ttyfast " Send more characters at a given time.

" ================= General Configuration =================

set number " Line numbers are good
set backspace=indent,eol,start " Allow backspace in insert mode
set history=999 " Store lots of :cmdline history
set undolevels=999 " Increase undos
set showcmd " Show incomplete cmds down the bottom
set showmode " Show current mode down the bottom
set gcr=a:blinkon0 " Disable cursor blink
set visualbell " No sounds
set autoread " Reload files changed outside vim
set nohidden " Close buffers immediately
set mouse=a " Mouse support in console
set fileformat=unix " Ditch the dirty CRLF
set clipboard=unnamed

" Turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away.
let mapleader=","
let maplocalleader=";"

" Crontab fix, don't use writebackup when editing crontab files.
autocmd filetype crontab setlocal nobackup nowritebackup

" Turn on Omni completion
"filetype plugin indent on
"set omnifunc=syntaxcomplete#Complete


" =================== Bootstrap vim-plug ==================

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" ==================== Install & Configure Plugins ====================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" fzf.vim
" Fuzzy finder vim configurations by the author
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" {{
" Use the standard fzf leader+f bindings
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

" Also set ctrlp bindings, because I always forget
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-P> :Files<CR>
" }}

" vinegar.vim
" vinegar.vim enhances netrw, to mitigate the need for project drawer plugins.
Plug 'tpope/vim-vinegar'

" lightline
" A light and configurable statusline/tabline plugin for vim
Plug 'itchyny/lightline.vim'
" {{
let g:lightline = {
  \   'colorscheme': 'wombat',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component': {
  \     'lineinfo': ' %3l:%-2v',
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }

let g:lightline.subseparator = {
  \   'left': '|', 'right': '|'
  \}
" }}

" vim-gitgutter
" A Vim plugin which shows a git diff in the gutter and stages/reverts hunks
Plug 'airblade/vim-gitgutter'

" vim-bufferline
" Super simple vim plugin to show the list of buffers in the command bar
Plug 'bling/vim-bufferline'

" asmM6502.vim : MOS 6502 Assembly syntax
" Syntax for the 6502, included 'Sally' (Atari8) ops
Plug 'vim-scripts/asmM6502.vim'

" Molokai-dark
" Molokai-dark is a darker and re-worked version of the Molokai theme by @tomasr.
Plug 'pR0Ps/molokai-dark'
" {{
let g:molokaidark_undercolor_gui = 1
let g:molokaidark_undercolor_cterm = 0
" }}

" vim-crystal
" Vim Filetype Support for Crystal
Plug 'vim-crystal/vim-crystal'
" {{
let g:crystal_auto_format = 1 " Turn on auto format on save for crystal filetype
" }}

"NERD Commenter
"Comment functions so powerful—no comment necessary.
Plug 'preservim/nerdcommenter'

" Initialize plugin system
call plug#end()

colorscheme molokai-dark


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

" Splits - feels more natural
set splitbelow
set splitright

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


" ========================= netrw ========================

" Make netrw use rm -r instead of rmdir so we can remove
" directories that have files
let g:netrw_localrmdir='rm -r'


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

" Asks the user yes or no
function! AskYN(message)
  echom a:message
  while 1
    let choice = input('y/n? ')
    if tolower(choice) == 'y'
      return 1
    elseif tolower(choice) == 'n'
      return 0
    else
      continue
    endif
  endwhile
endfunction

" Toggles highlighting text exceeding 80
function! ToggleHlLineLength()
  "highlight ColorColumn guibg=red
  if &colorcolumn == 0
    set colorcolumn=80
  else
    set colorcolumn=0
  endif
endfunction


"==================== Custom Commands =====================

" Count Occurences of previous search
" command CountOccurences :%s///gn
" command -nargs=1 CountOccurences /<f-args><bar>:%s///gn
command -nargs=1 CountOccurences :call SearchAndCountOccurences(<f-args>)

" Highlight text exceeding 80 characters
command -nargs=0 HlLineLength :call ToggleHlLineLength()


" ======================== Mapping ========================

" Freed <C-l> from Netrw
nmap <leader><leader><leader>l <Plug>NetrwRefresh

" Remap jj to escape in insert mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>
inoremap JJ <ESC>
nnoremap JJJJ <Nop>

" Easier split navigations
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" Delete and paste without affecting the buffer
" nnoremap <leader>d "_d
" xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

noremap <silent> <leader><Bslash> :let @/ = ''<CR>

" Setup toggling search highlighting
" nnoremap <silent> <C-l> :call ToggleHlsearch()<CR><C-l>:echo HlsearchStatus()<CR>

" Remap a to A in command mode
noremap a A

" Use Tab and S-Tab to switch between buffers
nnoremap  <silent>   <Tab>  :bnext<CR>
nnoremap  <silent> <S-Tab>  :bprevious<CR>

" Toggle highlighting text exceeding 80 characters
nnoremap <silent> <C-q> :call ToggleHlLineLength()<CR>

" Allow Shift+Tab for undent in insert mode
inoremap <S-Tab> <C-d>

" For compatability with other editors
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle


" =================== Filetype Specific ===================

" function! SyntaxForAsmM6502()
"  setlocal shiftwidth=4
"  setlocal softtabstop=4
"  setlocal tabstop=4
"  setlocal noexpandtab
"  if filereadable(expand("~/.vim/bundle/asmM6502.vim/syntax/asmM6502.vim"))
"    source ~/.vim/bundle/asmM6502.vim/syntax/asmM6502.vim
"  endif
" endfunction

autocmd FileType asm call SyntaxForAsmM6502()

" ======================= Statusbar =======================

set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]


" ============== Move Line/Visual up or down ==============

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" ================ Post Setup Instructions ================

" After a fresh setup with this vim config you should do the following.

" Install vim-plug
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

