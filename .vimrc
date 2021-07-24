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
Plug 'psf/black', { 'branch': 'stable' }

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
set splitright
set ignorecase
set smartcase
set tags+=/home/kewbish/EVB/tags

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

nnoremap <leader>te :let $VIM_DIR=expand('%:p:h')<CR>:tabnew <bar> term ++kill=hup<CR><C-w>_cd $VIM_DIR<CR>clear<CR>
nnoremap <leader>go :Goyo<CR>
nnoremap <leader>qa :qa!<CR>

let g:black_linelength=120
let g:black_quiet=1
autocmd BufWritePre *.py execute ':Black'

let g:fzf_action = {
  \ 'return': 'vsplit'}
command! -bang -nargs=* Sevb 
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': '/home/kewbish/EVB/'}, <bang>0)
autocmd FileType markdown setlocal noexpandtab
nnoremap <leader>ln va)y:exe ":Sevb " . substitute(substitute(getreg('"'), "\(#:", "", "/g"), "\)", "", "/g")<CR>
nnoremap <leader>st :silent !ctags -R . <CR>:redraw!<CR>:Tags<CR>
nnoremap <leader>se :Sevb<CR>
nnoremap <leader>sf :Files /home/kewbish/EVB/<CR>
nnoremap <expr> <leader>nq ':vimgrep /\[l' .nr2char(getchar()). '\]/ %<CR>'
nnoremap <leader>ll :s/\[l\d\]/\[l1\]/ <CR>
nnoremap <leader>rl :s/\[l\zs\d/\=submatch(0)+1/ <CR>

