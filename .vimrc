set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug '~/Downloads/dev/anchor.vim'

call plug#end()

colorscheme monocode

set linebreak
set number
set wrap
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin on
filetype plugin indent on
set autoindent
set autochdir
noremap j gj
noremap k gk
inoremap <C-h> <C-w>
set t_ut=
set incsearch
let g:netrw_banner=0
set splitbelow
set ignorecase
set smartcase

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

autocmd FileType markdown setlocal expandtab!
nnoremap <leader>te :let $VIM_DIR=expand('%:p:h')<CR>:tabnew <bar> term<CR><C-w>_cd $VIM_DIR<CR>clear<CR>
nnoremap <leader>go :Goyo<CR>
nnoremap gx vi]y:silent :!chromium <C-r>0<CR><CR><C-l>

nnoremap <expr> <leader>nq ':vimgrep /\[l' .nr2char(getchar()). '\]/ %<CR>'
nnoremap <leader>ll :s/\[l\d\]/\[l1\]/ <CR>
nnoremap <leader>rl :s/\[l\zs\d/\=submatch(0)+1/ <CR>

