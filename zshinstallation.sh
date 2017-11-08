#!/bin/bash

if [ -d "$HOME/.oh-my-zsh" ];then
	echo "oh-my-zsh already installed"
else
	echo "Installing oh-my-zsh"
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

if [ -f "$HOME/.oh-my-zsh/themes/honukai.zsh-theme" ];then
	echo "honukai.zsh-theme already installed"
else
	echo "Downloading honukai.zsh-theme"
	wget https://github.com/oskarkrawczyk/honukai-iterm-zsh/blob/master/honukai.zsh-theme -P $HOME/.oh-my-zsh/themes
fi

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/" ];then
	echo "zsh-syntax-highlighting already installed"
else
	echo "Installing zsh-syntax-highlighting"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
