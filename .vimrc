let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set noexpandtab
else
  set expandtab
  set cindent
  set cino=:0g0(0W4
endif
if _curfile =~ ".*\.cpp"
  set syntax=cpp.doxygen
  set matchpairs+=<:>
endif
set nocompatible
set linebreak
set showcmd

set foldmethod=marker

filetype on
filetype plugin on
filetype indent on

syntax enable
set grepprg=grep\ -nH\ $*

set autoindent
set smarttab

set softtabstop=2
set tabstop=2
set shiftwidth=2

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
