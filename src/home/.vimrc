set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
"Append-Plugins-Here
call vundle#end()
filetype plugin indent on

" nerdtree
command TT NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.pyc$']

" leader space
let mapleader="\<SPACE>"

" hotkey
nnoremap <Leader>w :w<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>l :b#<CR>
nnoremap <Leader>1 :b1<CR>
nnoremap <Leader>2 :b2<CR>
nnoremap <Leader>3 :b3<CR>
nnoremap <Leader>4 :b4<CR>
nnoremap <Leader>5 :b5<CR>
nnoremap <Leader>6 :b6<CR>
nnoremap <Leader>7 :b7<CR>
nnoremap <Leader>8 :b8<CR>
nnoremap <Leader>9 :b9<CR>

syntax enable
set t_Co=256
set t_ut=
set background=dark
try
    colorscheme gruvbox
catch
endtry

"ctrlp
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>f :CtrlPMRUFiles<CR>
"ignore files listed in .gitignore
"https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

set hidden
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
