"         
" ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
" ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
" ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
" ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
" 
"         @parakhatdin


call plug#begin("~/.vim/plugged")
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'tpope/vim-commentary'
    Plug 'lewis6991/gitsigns.nvim'
call plug#end()

lua require('gitsigns').setup()


set number
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set nobackup
"set termguicolors
set cursorline
colorscheme tokyonight-moon
let mapleader=','
set hidden
set nowrap

"NETRW
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
let g:netrw_hide=1
nnoremap <Leader>da :Lexplore<CR>
nnoremap <Leader>dd :Lexplore %:p:h<CR>

"Mapping
nnoremap <Leader>b :ls<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
