set nocompatible
imap jj <Esc>

" Highlighting
syntax on
hi Search term=reverse ctermfg=0 ctermbg=11 guibg=LightBlue
hi SpellBad term=reverse ctermbg=9 gui=undercurl guisp=Red
hi Error term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red
hi SignColumn term=standout ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
hi Visual term=reverse cterm=reverse ctermbg=0

" indentation
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab

" build
" map <F5> <Esc>:wa<CR>:!make -j 4<CR>
" map <F5> <Esc>:wa<CR>:!cd ./build && cmake .. && make -j 4 && ./tests;<CR>
map <F5> <Esc>:wa<CR>:!cd ./build && make -j 4 && ./tests;<CR>

" movement on wrapped lines
nmap j gj
nmap k gk

" Highlight search
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap \q :nohlsearch<CR>

" Panes
map zh <C-W>h
map zj <C-W>j
map zk <C-W>k
map zl <C-W>l
map zs <C-W>s
map zv <C-W>v

" Useful shortcuts
map zq :q<CR>
map zw :w<CR>
map ze :e 

" The default text register is the clipboard.
set clipboard+=unnamed
set backspace=indent,eol,start

" ~~~~~~ Vundle ~~~~~~ 

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'

Plugin 'valloric/youcompleteme'

Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdtree'

Plugin 'easymotion/vim-easymotion'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'greplace.vim'

call vundle#end()            " required

filetype plugin indent on    " required

" ~~~~~~~ YouComleteMe ~~~~~~
 
nnoremap <F4> :YcmCompleter GoTo<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

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


" ~~~~~~~~ NERDtree ~~~~~~~~

" Workaround to map alt...
execute "set <M-1>=1"
map <M-1> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

let NERDTreeIgnore = ['\.[do]$']

" Used to close vim if NERDtree is the last windows


" ~~~~~~~~ EasyMotion ~~~~~~~
let g:EasyMotion_do_mapping = 0 " Disable default mappings

let g:EasyMotion_smartcase = 1

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion


" ~~~~~~~~ CtrlP ~~~~~~~

" let g:ctrlp_custom_ignore = '\v\.(o|d|so)$'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

map zp :CtrlP<Enter>

" let g:ctrlp_prompt_mappings = {'PrtExit()': ['<esc>', '<c-c>', '<c-g>', 'jj'],}
" TODO: try to fix jj to exit CtrlP`

" ~~~~~~~~ Multiple Cursor ~~~~~~~

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


