" Note: Options are commented out below because functionality is provided by other plugins

" Setup NERDTree (Not using since it double opens NERDTree when a directory is specified)
" autocmd VimEnter * NERDTree

" Open NERDTree automatically when vim starts up even if no files specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Change the default arrows (Note that below are default arrow symbols)
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Make enter key open files in new tabs, we use a plugin to prevent directories from opening in tabs
let NERDTreeMapOpenInTab='<CR>'

" Remove 'Press ? for help'
let NERDTreeMinimalUI=1
