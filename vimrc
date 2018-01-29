set nocompatible              " be iMproved, required
filetype off                  " required
colorscheme molokai


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

call vundle#end()            " required
filetype plugin indent on    " required

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
map <leader>pf :CtrlP<CR>
map <leader>pb :CtrlPBuffer<CR>
map <leader>pm :CtrlPMixed<CR>

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


map <leader>b :BuffergatorToggle<CR>
