" plugins list
"
" https://github.com/Tumbler/highlightMarks
" https://github.com/bogado/file-line
" https://github.com/scrooloose/nerdtree.git
"

colorscheme slate
let TABWIDTH = 4
let MAXLINEWIDTH = 100

set nowrap
set tabstop=TABWIDTH
set shiftwidth=TABWIDTH
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


if (index(source_code_extensions, extension) >= 0 || filename =~# '\.\w\+')
    set colorcolumn = MAXLINEWIDTH
    set foldmethod = syntax
    syntax on

    match EolWhitespace /\s\+$/
    match EolTabs /\t/
endif

function! SetTwoColumnView()                                                                        
    vsplit                                                                                          
    exe "normal 2\<C-W>w\<C-F>"                                                                     
    windo setlocal scrollbind                                                                       
endfunction

function! RegenerateTags()
    exe ":!ctags -R ."
endfunction

map <F8> :set number! <CR>
map <F9> :NERDTreeToggle<CR>
map <F10> :call  SetTwoColumnView() <CR>
map <F11> :call RegenerateTags() <CR>
