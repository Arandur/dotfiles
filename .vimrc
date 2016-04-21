set nocompatible
set linebreak
set showcmd

set foldmethod=syntax

filetype on
filetype plugin on
filetype indent on

syntax enable
set grepprg=grep\ -nH\ $*

set autoindent
set smarttab

set synmaxcol=10000

if version >= 700
  set spl=en spell
  set nospell
endif

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

nore ; :
nore , ;
nore \ :noh<CR>

set background=dark

set expandtab

let _curfile = expand("%:t")

set softtabstop=2
set tabstop=2
set shiftwidth=2

if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set noexpandtab
endif

if _curfile =~ ".*\.cpp"
  set syntax=cpp.doxygen
  set matchpairs+=<:>
  set cindent
  set cino=:0g0(0W4
endif

if _curfile =~ ".*\.htm[l]"
  set filetype=html
  set matchpairs+=<:>
endif

if _curfile =~ ".*\.java"
  set cindent
  set cino=:0g0(0W4
endif

if _curfile =~ ".*\.md"
  set conceallevel=2
endif

if _curfile =~ ".*\.rkt"
  set syntax=racket
  set cinkeys-=0#
  set indentkeys-=0#
  set softtabstop=1
  set tabstop=1
  set shiftwidth=1
  set lisp
endif

execute pathogen#infect()
