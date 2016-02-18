"  Enable OmniComplete
set omnifunc=syntaxcomplete#Complete

" Ensure the tags folder is created
silent !mkdir ~/.vim/tags > /dev/null 2>&1

" Add tags
set tags+=~/.vim/tags/tags
" set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/gl
" set tags+=~/.vim/tags/qt

" Use a function to bild ctags for the current directory
function BuildLocalCtags()
  echo "Building ctags"
  !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/tags/project .
  redraw!
  set tags+=~/.vim/tags/project
  echo "Completed building ctags"
endfunction

" Build tags of your own project with Ctrl-\
map <c-\> :call BuildLocalCtags()<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Fix enter key functionality when using the completion menu
noremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

