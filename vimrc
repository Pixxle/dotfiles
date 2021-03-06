set nocompatible              " be iMproved, required
set noswapfile
filetype off    " required

" Tab is 4 spaces, I'm not a savage
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " required

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'davidhalter/jedi-vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'fatih/vim-go'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'andviro/flake8-vim'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme desert
syntax on

" Remove arrow keys, i default back to them if i have them available
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Leader mapping
let mapleader = ","

map <leader>tt :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>te :tabedit
map <leader>tf :tabfind
map <leader>tc :tabclose<CR>
map <leader>tn :tabnext<CR>

" NerdTree configuration
map <leader>n :NERDTreeToggle<CR>


" CTRLP configuration
map <leader>ff :CtrlP<CR>
map <leader>fb :CtrlPBuffer<CR>

" Easy motion
map <SPACE>  <Plug>(easymotion-sn)
map <SPACE>l <Plug>(easymotion-bd-jk)
map <SPACE>w <Plug>(easymotion-bd-w)
map <SPACE>c <Plug>(easymotion-bd-f)

" Git configuration
map <leader>gw :Gwrite<CR>
map <leader>gc :Gcommit -v -q<CR>
map <leader>gp :Gpush<CR>

" Go configuration
map <leader>gob :GoBuild<CR>
map <leader>gor :GoRun<CR>
map <leader>got :GoTest<CR>
map <leader>god :GoDef<CR>

" Buffergator configuration
map <leader>b :BuffergatorToggle<CR>

" Flake8 Configuration 
let g:PyFlakeOnWrite = 1
map <leader>pyf :PyFlake<CR>

" Jedi-vim configuration
let g:jedi#rename_command = "<leader>pyr"
let g:jedi#documentation_command = "<leader>pydoc"
let g:jedi#goto_command = "<leader>pyg"
let g:jedi#completions_command = "<leader>pyc"
