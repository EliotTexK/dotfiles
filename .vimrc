set number
set tabstop=4
set shell=/bin/bash
set linebreak
set clipboard^=unnamed,unnamedplus
syntax on
" allows pasting without autoindent
set paste

" changes the cursor to a line when in insert mode

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" fixes cursor change delay

set ttimeout
set ttimeoutlen=1
set ttyfast

" vim plug is the standard for installing vim plugins
" I will get this to work one day, goddamit!

call plug#begin()

Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" vim-markdown
" don't fold bc buggy
let g:vim_markdown_folding_disabled = 1

" markdown-preview.nvim
" Look in the github repo for info about what they do!
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow= 1
let g:mkdp_markdown_css= '/home/eliot/.vim/light-dark.css'
let g:mkdp_browser = 'chromium'
let g:mkdp_page_title = 'Markdown Preview'

call plug#end()
