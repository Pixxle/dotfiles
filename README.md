# Dotfiles configuration

## VIM:
* Install Vundle
* Copy vimrc
* Setup color schemes
`
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vimrc ~/.vimrc
mkdir -p ~/.vimrc/colors
git clone https://github.com/flazz/vim-colorschemes.git ~/temp
cp ~/temp/colors/* ~/.vimrc/colors/
rm -rf ~/temp`
