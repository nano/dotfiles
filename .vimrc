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

if has("mouse")
  set mouse=a
endif

syntax on
colorscheme desert
filetype plugin indent on

if has("autocmd")
  au FileType python setlocal sw=4 sts=4 et
  au FileType ruby,eruby,yaml setlocal sw=2 sts=2 et
  au FileType html,xhtml,xml setlocal sw=2 sts=2 et
  au FileType php setlocal sw=4 sts=4 et
  au FileType sh setlocal sw=2 sts=2 et
  au FileType javascript setlocal sw=2 sts=2 et

  " Remember last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

let python_highlight_all=1
let use_xhtml=1

" vim: ts=2 sw=2 et
