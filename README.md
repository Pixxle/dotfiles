# Dotfiles configuration

## VIM:

* Install Vundle:
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

* Copy vimrc:
`cp vimrc ~/.vimrc`

* Color schemes:
`mkdir -p ~/.vimrc/colors
git clone https://github.com/flazz/vim-colorschemes.git ~/temp
cp ~/temp/colors/* ~/.vimrc/colors/
rm -rf ~/temp`
