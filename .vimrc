set nocompatible               " be iMproved
filetype off                   " required!


call plug#begin('~/.vim/plugged')

 Plug 'scrooloose/nerdtree'
 Plug 'scrooloose/nerdcommenter'
 Plug 'tpope/vim-fugitive'
 Plug 'mattn/gist-vim'
 Plug 'junegunn/fzf'
 Plug 'junegunn/fzf.vim'

 " Editing
 Plug 'mileszs/ack.vim'
 Plug 'tpope/vim-unimpaired'

 " Languages
 Plug 'fatih/vim-go'
 Plug 'sheerun/vim-polyglot'
 Plug 'derekwyatt/vim-scala'
 Plug 'pangloss/vim-javascript'
 Plug 'mxw/vim-jsx'

" call PlugInstall to install new plugins
call plug#end()


" Set style
"===

syntax enable
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
set t_ut=

set wildmenu
set wildmode=longest:list,full
set scrolloff=3
set autoindent

set modeline
set number

set tabstop=4
set shiftwidth=4
set expandtab

set breakindent
set breakindentopt=shift:4,sbr
set showbreak=-->

set spelllang=en,de
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set formatoptions+=j
set foldmethod=indent
set foldlevel=1

set undodir=~/.dots/vim-undo
set undofile

set mouse=a

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <C-r> :NERDTreeToggle<CR>



