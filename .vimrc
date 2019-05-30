" plugins list
"
" https://github.com/Tumbler/highlightMarks
" https://github.com/bogado/file-line
" https://github.com/scrooloose/nerdtree.git
"

colorscheme slate

set nowrap
set tabstop=4
set shiftwidth=4
set number
set cursorline
set hlsearch
set nofixendofline
set expandtab

let filename = expand('%:t')
let extension = expand('%:e')

let source_code_extensions = [
    \'py', 'cpp', 'js', 'h', 'hpp', 'cc', 'hh', 'sh', 'md', 'bashrc', 'vimrc'
\]

highlight Folded ctermbg=darkgrey ctermfg=white
highlight EolWhitespace ctermbg=red guibg=red
highlight EolTabs ctermbg=red guibg=red


let g:highlightMarks_cterm_colors = [23]
map <F9> :NERDTreeToggle<CR>


if (index(source_code_extensions, extension) >= 0 || filename =~# '\.\w\+')
    set colorcolumn=100
    set foldmethod=syntax
    syntax on

    match EolWhitespace /\s\+$/
    match EolTabs /\t/
endif



map <F8> :set number! <CR>

