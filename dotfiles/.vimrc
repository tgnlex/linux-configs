"
"REQUIRED = download plug.vim via curl " 
"---------- SETTINGS ----------"
let mapleader = " "
colorscheme molokai
filetype on
filetype plugin on
filetype indent on 
syntax on

set nocompatible
set number
set expandtab
set shiftwidth=4
set tabstop=4
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.img,*.xlsx
" -------------------------------"
" ---------- PLUGINS ----------- "
call plug#begin('~/.vim/plugged')
  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-obsession'
  Plug 'jreybert/vimagit'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'sirver/ultisnips'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
" ------------------------------ "

" ---------- KEYMAPS ----------- "
map <C-space> ?
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>w :w!<cr>
map <leader>q :q!<cr>
map <leader>qa :qa!<cr>
map <leader>bd :Bclose<cr>
map <leader>ba :1,100 bd!<cr>
map <leader>tn :tabnew<cr>
map <leader>h :split<cr>
map <leader>v :vsplit<cr>
noremap <F12> :PlugInstall<cr>
noremap <F2> :NERDTreeToggle<cr>
noremap <F3> :terminal<cr>  
noremap <F4> :read !date<cr>

nnoremap O O<esc>
nnoremap o o<esc>
" ----------- VIMSCRIPT ------------"

function! s:hl_yank(duration) abort
    if v:event.operator !=# 'y' | return | endif
    let l:pos = getregionpos(getpos("'["), getpos("']"), {'type': v:event.regtype})
    let l:m = matchaddpos('IncSearch', mapnew(l:pos, {_, v -> [v[0][1], v[0][2], v[1][2] - v[0][2] + (v:event.inclusive || v:event.regtype ==# 'V' ? 1 : 0)]}))
    let l:winid = win_getid()
    call timer_start(a:duration, {-> matchdelete(l:m, l:winid)})
endfunction
" --------- AUTOCOMMANDS ---------- "
""" Set fold based on filetype """
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
""" Highlight on yank """
augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! call s:hl_yank(300)
augroup END
" -------------------------------"
"
" --------- STATUS LINE -------- "

set statusline=

" Left side info
set statusline+=%F    " Full path to the file
set statusline+=%m    " Modified flag [+] if the file has unsaved changes
set statusline+=%r    " Read-only flag [RO]
set statusline+=%y    " File type (e.g., [python])

" Right-align alignment separator
set statusline+=%=

" Right side info
set statusline+=[%{&fileencoding}] " File encoding (e.g., utf-8)
set statusline+=\ %l          " Current line number
set statusline+=/%L           " Total lines in the file
set statusline+=,%c           " Current column number
set statusline+=\ %P          " Percentage through the fil
" ------------------------------ "
" ------------ MISC ------------ "
let NERDTreeShowHidden=1
