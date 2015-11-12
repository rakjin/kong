set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-rails'
Plugin 'L9'
Plugin 'FuzzyFinder'
"Append-Plugins-Here
call vundle#end()
filetype plugin indent on

command TT NERDTree
let NERDTreeShowHidden=1

command FF FufCoverageFile
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|class)$|(^|[/\\])\.(hg|git|bzr|bundle)($|[/\\])|^(vendor|tmp|log|public)($|[/\\])'


set encoding=utf-8
set termencoding=utf-8

syntax enable
set t_Co=256
set t_ut=
set background=light
try
    colorscheme gruvbox
catch
endtry

set number
set ruler
highlight ColorColumn ctermbg=8
set colorcolumn=81,121
set listchars=tab:>-,trail:-
set list
set scrolloff=13

set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
autocmd FileType ruby set shiftwidth=2 tabstop=2

set ignorecase
set hlsearch
set incsearch

set nobackup
set nowritebackup
set noswapfile
