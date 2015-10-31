set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
"Append-Plugins-Here
call vundle#end()
filetype plugin indent on

syntax enable
set t_Co=256
set background=dark
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
