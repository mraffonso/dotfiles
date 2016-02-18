" Add ctrlp to the runtimepath
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Switch <cr> and <c-t> so <cr> defaults to open in a new tab
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }
