# Fittest-IDE Makefile for *NIX system. 

install:
	mkdir -p ~/.vim/autoload
	cp plugins/plug.vim ~/.vim/autoload
	mkdir -p ~/.config/nvim
	cp config/init.vim ~/.config/nvim
	cp config/liquidpromptrc ~/.config
	cp config/tmux.conf ~/.tmux.conf
	cp config/zshrc ~/.zshrc
