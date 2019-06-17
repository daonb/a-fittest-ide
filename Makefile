# Fittest-IDE Makefile for *NIX system. 
home = ~/.fittestide
lp_path = $(home)/liquidprompt

$(home):
	mkdir ~/.fittestide

$(lp_path): $(home)
	git clone git@github.com:nojhan/liquidprompt.git $(lp_path)

install: $(lp_path) shell
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	mkdir -p ~/.tmux
	cp plugins/plug.vim ~/.vim/autoload
	cp config/init.vim ~/.config/nvim
	cp config/liquidpromptrc ~/.config
	cp config/tmux.conf ~/.tmux.conf
	cp config/zshrc ~/.zshrc
	cp config/tmux_skin.conf ZZ~/.tmux/skin.conf

shell:
	chsh -s `which zsh`
