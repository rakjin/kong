set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'bling/vim-airline'
"Append-Plugins-Here
call vundle#end()
filetype plugin indent on

syntax enable
set t_Co=256
set t_ut=
set background=dark
try
    colorscheme gruvbox
catch
endtry

"vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

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
