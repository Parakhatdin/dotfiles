call plug#begin("~/.vim/plugged")
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'tpope/vim-commentary'
call plug#end()


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

