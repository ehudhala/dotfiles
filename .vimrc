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

" Plug 'valloric/youcompleteme'

" Plug 'tpope/vim-fugitive'

" Plug 'easymotion/vim-easymotion'

" Plug 'ctrlpvim/ctrlp.vim'

" Plug 'terryma/vim-multiple-cursors'

" Plug 'greplace.vim'

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
