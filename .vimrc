" plugins list
" -------------------
" https://github.com/Tumbler/highlightMarks
" https://github.com/bogado/file-line
" https://github.com/scrooloose/nerdtree.git
" https://github.com/xavierd/clang_complete
" https://github.com/yegappan/taglist
"
"   Run:
"       CXX="/home/mmichalski/.vim/pack/vendor/start/clang_complete/bin/cc_args.py g++" cmake ..
"       make
"   in order to generate .clang_complete file from cmake prooject.
"
" https://github.com/ervandew/supertab.git
" https://github.com/tpope/vim-fugitive.git
"

" cheatsheet
" -------------------
" <Ctrl-v> {select lines} <Shift-I> // <ESC><ESC>                 comment code block
" <Ctrl-v> {select two first columns of commented lines} <x>      uncomment
"

" other stuff
" -------------------
" on ubuntu copy to clipboard (requires sudo apt install vim-gnome)
"    "+yy - copy to secondary clipboard (ctrl + v)
"    "*yy - copy to primary clipboard (middle mouse btn)

scriptencoding utf-8
set encoding=utf-8

colorscheme slate

set nowrap
let &l:tabstop=4
let &l:shiftwidth=4
set number
"set relativenumber
set cursorline
set hlsearch
set nofixendofline
set expandtab

" :find foo<TAB> finds all files recursively
set wildmenu
set path+=**

" set clang_library_path to the libclang file, the directory setting seems to be broken.
let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'
set shortmess+=c

let filename = expand('%:t')
let extension = expand('%:e')

let source_code_extensions = [
    \'py', 'cpp', 'js', 'h', 'hpp', 'cc', 'hh', 'sh', 'md', 'bashrc', 'vimrc'
\]

highlight Folded ctermbg=darkgrey ctermfg=white
highlight EolTabs ctermbg=red guibg=red
highlight EolWhitespace ctermbg=red guibg=red

let g:highlightMarks_cterm_colors = [23]


if (index(source_code_extensions, extension) >= 0 || filename =~# '\.\w\+')
    set foldmethod=syntax
    let &l:colorcolumn=100
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

" example of mapping a snippet file into normal mode command
nnoremap ,for :-1read $HOME/.vim/snippets/forloop.cpp.in<CR>/X<CR>
nnoremap :todo :120vs ~/.todo<CR>

" custom key mappings
map <F3> :todo <CR>
map <F5> :!sh -xc "xdotool search --onlyvisible --class Chrome windowfocus key ctrl+r"<CR>
map <F7> :TlistToggle<CR>
map <F8> :set number! <CR>
map <F9> :NERDTreeToggle<CR>
map <F10> :call  SetTwoColumnView() <CR>
map <F11> :call RegenerateTags() <CR>
