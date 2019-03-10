" Panes
map zh <C-W>h
map zj <C-W>j
map zk <C-W>k
map zl <C-W>l
map zs <C-W>s
map zv <C-W>v

" Useful shortcuts
imap jj <Esc>
map zq :q<CR>
map zw :w<CR>
map ze :e 

" indentation
set tabstop=4
set shiftwidth=4
set expandtab
 
" movement on wrapped lines
nmap j gj
nmap k gk

" Highlight search
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap \q :nohlsearch<CR>

" Plugins

call plug#begin('~/.local/share/nvim/plugged')

Plug 'erichdongubler/vim-sublime-monokai'

Plug 'scrooloose/nerdtree'

Plug 'scrooloose/nerdcommenter'

Plug 'valloric/youcompleteme'

" Plug 'easymotion/vim-easymotion'

Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" Syntax highlighting
syntax enable
colorscheme sublimemonokai
set termguicolors

" ~~~~~~~~ NERDtree ~~~~~~~~

map <M-1> :NERDTreeToggle<CR>

" Used to close vim if NERDtree is the last windows
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

let NERDTreeIgnore = ['\.[do]$']

" ~~~~~~~ NERD Commenter ~~~~~~

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ~~~~~~~~ CtrlP ~~~~~~~

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

map zp :CtrlP<Enter>

" ~~~~~~~ YouComleteMe ~~~~~~

nnoremap <F4> :YcmCompleter GoTo<CR>

let g:ycm_global_ycm_extra_conf = '~/dotfiles/.ycm_extra_conf.py'
