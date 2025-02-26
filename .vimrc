" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of
" file is use.
filetype on

" Turn syntax highlighting on.
syntax on

" Show the mode you are on the last line.
set showmode

" Leader
let mapleader = " "

" Line numbers
set nu
set relativenumber

" Tabs and indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Text wrapping
set nowrap

" Swap and backup files
set noswapfile
set nobackup

" Searching
set nohlsearch
set incsearch

" Colors and UI
set scrolloff=8
set signcolumn=yes
set updatetime=50
set colorcolumn=80

" Open file explorer (equivalent to :Ex)
nnoremap <leader>pv :Ex<CR>

" Move selected lines up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Regex replace word under the cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>
vnoremap <leader>s "hy:%s/<C-r>h//g<left><left>

" Delete to black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Scroll and center cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Make file executable
nnoremap <leader>ex :!chmod +x %<CR>
