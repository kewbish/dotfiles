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
Plug 'antoinemadec/coc-fzf'
Plug 'rhysd/vim-clang-format'
" Plug 'github/copilot.vim'
Plug '~/Downloads/dev/chasm-213'
" Plug 'jalvesaq/zotcite'
Plug 'img-paste-devs/img-paste.vim'

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
let g:netrw_localrmdir='rm -rf'

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"

nnoremap <leader>te :let $VIM_DIR=expand('%:p:h')<CR>:tabnew <bar> below new <bar> term<CR><C-w>_icd $VIM_DIR<CR>clear<CR>
nnoremap <leader>gg :GFiles<CR>
nnoremap <leader>go :Goyo<CR>
nnoremap <leader>qa :qa!<CR>
nnoremap <leader>cpa :let @+ = expand("%:p")<CR>
nnoremap <silent>gd <Plug>(coc-definition)
nnoremap <silent>gD <Plug>(coc-references)
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>
let g:coc_node_path = '/home/kewbish/n/bin/node'

let g:black_linelength=120
let g:black_quiet=1
" autocmd BufWritePre *.py Black
" autocmd BufWritePre *.js,*.ts,*.tsx,*.jsx,*.html,*.css Prettier
autocmd FileType cpp ClangFormatAutoEnable
autocmd BufWritePre *cpp execute ':ClangFormat'
let g:clang_format#code_style='google'
augroup filetypedetect
    au BufRead,BufNewFile *.sage set filetype=python
    au BufRead,BufNewFile *.s set filetype=sm213 " TODO - take me out!
augroup END

function! s:insert_fzf_link(lines)
    execute "normal! va]\<Esc>a(/home/kewbish/EVB/" . a:lines[0] . ")\<Esc>"
endfunction
let g:fzf_action = {
  \ 'return': 'vsplit', 'ctrl-r': function("s:insert_fzf_link")}
command! -bang -nargs=* Sevb 
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always -i ".shellescape(<q-args>), 1, {'dir': '/home/kewbish/EVB/'}, <bang>0)
" \ call fzf#vim#grep("rg -g '!archive/' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': '/home/kewbish/EVB/'}, <bang>0)
autocmd FileType markdown setlocal noexpandtab
nnoremap <leader>ln va)y:exe ":Sevb " . substitute(substitute(getreg('"'), "\(#:", "", "/g"), "\)", "", "/g")<CR><CR>
nnoremap <leader>st :Sevb \(#:<CR>
nnoremap <leader>se :Sevb<CR>
nnoremap <leader>sd :Sevb \(#: TODO\)<CR>
nnoremap <leader>sf :Files /home/kewbish/EVB/<CR>
command G GFiles
vnoremap <leader>cl c(#: <C-r>")<C-c>

" imap <silent><script><expr> <C-P> copilot#Accept("\<CR>")
" nnoremap <leader>cpl :Copilot<CR>
" let g:copilot_no_tab_map = v:true

augroup notes
    autocmd!
    autocmd FileType markdown syntax match CorrodeMyNote /\v\(MN\)/
    autocmd FileType markdown syntax match CorrodeClassmateNote /\v\(CN\)/
    autocmd FileType markdown syntax match CorrodeQuestion /\v\(\?\)/
    autocmd FileType markdown syntax match CorrodeAnsweredQuestion /\v\(\?v\)/
    autocmd FileType markdown syntax match YKConceal /\v(\(\#G\s)/ conceal
    autocmd FileType markdown syntax match YKConceal /\v(\(\#G\s(.*))@<=\)/ conceal
    autocmd FileType markdown syntax match YKExample /\v(\(\#G\s)@<=([^\)]*)\)@=/
    autocmd FileType markdown syntax match PurpleHighlight /\v\(\#:(.*)\)/
    autocmd FileType markdown hi PurpleHighlight ctermfg=189 guifg=#b3a0de	
    autocmd FileType markdown hi CorrodeMyNote ctermfg=140 guifg=#af87d7	
    autocmd FileType markdown hi CorrodeClassmateNote ctermfg=152 guifg=#afd7d7
    autocmd FileType markdown hi CorrodeQuestion ctermfg=203 guifg=#ff5f5f
    autocmd FileType markdown hi CorrodeAnsweredQuestion ctermfg=121 guifg=#88ff88	
    autocmd FileType markdown hi YKExample ctermfg=121 guifg=#88ff88	
    autocmd FileType markdown setlocal conceallevel=3
augroup END
inoremap <leader>mn (MN)
inoremap <leader>cn (CN)
autocmd FileType markdown let b:surround_187 = "« \r »"

autocmd FileType markdown nmap <buffer><silent> <C-i> :call mdip#MarkdownClipboardImage()<CR>
if expand('%:h') == "/home/kewbish/EVB/yours"
    let g:mdip_imgdir_absolute = '/home/kewbish/Downloads/dev/yours-kewbish/static/images/' . substitute(expand('%:t'), "\.md", "", "") . "/"
    let g:mdip_imgdir_intext = '/' . substitute(expand('%:t'), "\.md", "","")
endif

set guicursor=
set laststatus=1
set nohlsearch
autocmd TermOpen * setlocal nonumber norelativenumber
tnoremap <C-w>N <C-\><C-n>
tnoremap <C-w>k <C-\><C-n><C-w>k
let g:python3_host_prog = '/usr/bin/python'

au BufRead,BufNewFile *.ys setfiletype asm
