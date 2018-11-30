set encoding=utf8
set nocompatible
set ruler
set number
set cindent
set autoindent
set tabstop=8
set shiftwidth=8
set noexpandtab
set modeline
set modelines=5
set nowrap
set hlsearch
set incsearch
set nofoldenable
set showmatch
set backspace=indent,eol,start
set splitright
set splitbelow
set t_Co=256
set tags=./tags;/
set background=dark
set noswapfile

let mapleader=","

nmap <leader>o :CtrlPTag<cr>
nmap <leader>p :CtrlP<cr>

set fillchars+=vert:\ 
highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

if has("mouse")
  set mouse=a
endif

syntax on
filetype plugin indent on

execute pathogen#infect()

" Ruby
au FileType ruby,eruby,yaml setlocal sw=2 sts=2 et

" Shell
au FileType sh setlocal sw=2 sts=2 et

" JavaScript
au FileType javascript setlocal sw=2 sts=2 et

" C
au FileType c,h setlocal ts=8 sw=8 sts=8 noet

" Markdown
au BufRead,BufNewFile *.mkd,*.md,*.markdown setfiletype mkd

" Thrift
au BufRead,BufNewFile *.thrift set ft=thrift

" Python
let python_highlight_all=1
au FileType python setlocal sw=4 sts=4 et
au FileType python nmap <leader>f :call Flake8()<cr>
au FileType python nmap <leader>i ma<cr>:%!isort -<cr>`a<cr>k
au FileType python nmap <leader>b ma<cr>:%!black -q -<cr>`a<cr>k

" HTML
let use_xhtml=1
au FileType html,xhtml,xml setlocal sw=2 sts=2 et

" Go
let g:go_fmt_command = "goimports"
au FileType go setlocal sw=8 ts=8 noet

" vim: ts=2 sw=2 et
