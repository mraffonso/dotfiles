"                   _ _        
" __ ___  _ _ _  __| | |___ ___
" \ V / || | ' \/ _` | / -_|_-<
"  \_/ \_,_|_||_\__,_|_\___/__/
"

filetype off                  " required

" ========================= Init ==========================

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/vundles/ " Submodules
call vundle#begin()

" ======================== Vundles ========================

" Let Vundle manage Vundle.
Plugin 'gmarik/Vundle.vim'

" Split up vundles in ~/.vim/vundles/ to making editing easier.
runtime ctrlp.vundle

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

" Configurations added to ~/.vim/vundles/settings will be added
" This helps to keep configurations separate and easily loaded
for fpath in split(globpath('~/.vim/vundles/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
