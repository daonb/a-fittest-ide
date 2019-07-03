set nocompatible              " required
filetype off                  " required
color elflord
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'python-mode/python-mode'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug 'vim-syntastic/syntastic'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
call plug#end()
filetype plugin indent on    " required
syntax on
set colorcolumn=80
set tabstop=4
set shiftwidth=0    " Use tabstop
set softtabstop=-1  " Use shiftwidthset shiftwidth=4
set expandtab
set laststatus=2
set statusline=%4l:%3c/%4L:\ %f
set statusline+=%#warningmsg#
set statusline+=%*
set encoding=utf-8
set clipboard=unnamed
set relativenumber
set number

let mapleader = ","
let python_highlight_all=1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['jshint']
" let g:SimpylFold_docstring_preview=1
let g:python_host_prog = "~/.pyenv/versions/afide2/bin/python"
let g:python3_host_prog = "~/.pyenv/versions/afide3/bin/python"
let g:pymode = 1
let g:pymode_options = 1
let g:pymode_folding = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_rope = 1
let g:pymode_virtualenv = 1
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_quickfix_maxheight = 1
let g:pymode_indent = 1
let g:pymode_rope_show_doc_bind = '<C-c>d'
let g:pymode_rope_complete_on_dot = 0
let g:pymode_python = 'python'
let g:tmux_navigator_disable_when_zoomed = 1
set foldmethod=indent
set foldlevel=99

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <space> za
map <F3> :NERDTreeToggle<CR>
" au BufNewFile,BufRead *.py 
au FileType py 
    \ set tabstop=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix 
" au BufNewFile,BufRead *.js, *.html, *.css
au FileType js, html, css
    \ set tabstop=2
