set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/run/media/kewbish/09CA611864AA9A0F/dev/blank.vim/'
Plug 'junegunn/goyo.vim'

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
noremap gj j
noremap gk k
inoremap <C-h> <C-w>
set t_ut=
set incsearch
let g:netrw_banner=0
set splitbelow

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

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <F5> <C-R>=strftime("%-d %B %Y")<CR>

autocmd FileType markdown setlocal expandtab!

nnoremap <expr> <leader>nq ':vimgrep /\[l' .nr2char(getchar()). '\]/ %<CR>'
nnoremap <leader>ll :s/\[l\d\]/\[l1\]/ <CR>
nnoremap <leader>rl :s/\[l\zs\d/\=submatch(0)+1/ <CR>

nnoremap <leader>te :tabnew <bar> term <CR><C-w>_
