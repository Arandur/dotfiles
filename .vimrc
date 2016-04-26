execute pathogen#infect()

set nocompatible
set linebreak
set showcmd

filetype on
filetype plugin on
filetype indent on

syntax enable
set grepprg=grep\ -nH\ $*

set autoindent
set smarttab

if version >= 700
  set spl=en spell
  set nospell
endif

set synmaxcol=10000

compiler gcc

set wildmenu
set wildmode=list:longest,full

set number

set ignorecase
set smartcase

set incsearch
set hlsearch

let g:clipbrdDefaultReg = '+'

set nohidden

highlight MatchParen ctermbg=4

nnoremap <space> za

nore \ :noh<CR>

set background=dark
set foldmethod=syntax

set softtabstop=2
set tabstop=2
set shiftwidth=2

set expandtab

" Filetype-specific settings
let _curfile = expand("%:t")

" Makefiles
if _curfile =~? 'Makefile\|\.mk$'
  set noexpandtab
endif

" C++
if _curfile =~? '\.\(cpp\|t\?cc\|h\|hpp\)$'
  set syntax=cpp.doxygen
  set matchpairs+=<:>
  set cindent
  set cino=:0g0(0W4
endif

" C
if _curfile =~? '\.c$'
  set cindent
  set cino=:0g0(0W4
endif

" Racket
if _curfile =~? '\.rkt$'
  set softtabstop=1
  set tabstop=1
  set shiftwidth=1
  set cindent
  set cinkeys-=0#
  set indentkeys-=0#
  set cino=g0(0
  set foldmethod=indent
endif

" Java
if _curfile =~? '\.java$'
  set cindent
  set cino=:0g0(0W4
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
endif

" Pollen
au BufRead,BufNewFile *.*.p set filetype=pollen

" Utility functions
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//g
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
