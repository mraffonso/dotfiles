"  Enable OmniCppComplete
set omnifunc=syntaxcomplete#Complete

" Ensure the tags folder is created
silent !mkdir ~/.vim/tags > /dev/null 2>&1

" Add tags
set tags+=~/.vim/tags/tags

