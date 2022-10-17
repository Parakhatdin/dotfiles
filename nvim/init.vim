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

