"                   _ _        
" __ ___  _ _ _  __| | |___ ___
" \ V / || | ' \/ _` | / -_|_-<
"  \_/ \_,_|_||_\__,_|_\___/__/
"

filetype off                  " required

" ========================= Init ==========================

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ======================== Vundles ========================

" Let Vundle manage Vundle.
Plugin 'gmarik/Vundle.vim'

" ctrlp
"
" Brief help
" :helptags ~/.vim/bundle/ctrlp.vim/doc
Plugin 'kien/ctrlp.vim'

" ========================== End ==========================

" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ================== Plugin Configuration =================

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
