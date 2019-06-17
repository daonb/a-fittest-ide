# Fittest-IDE Makefile for *NIX system. 
home = ~/.fittestide
lp_path = $(home)/liquidprompt

$(home):
	mkdir ~/.fittestide

$(lp_path): $(home)
	git clone git@github.com:nojhan/liquidprompt.git $(lp_path)

install: $(lp_path) pyenv nvim shell
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	mkdir -p ~/.tmux
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	cp config/init.vim ~/.config/nvim
	cp config/liquidpromptrc ~/.config
	cp config/tmux.conf ~/.tmux.conf
	cp config/zshrc ~/.zshrc
	cp config/tmux_skin.conf ~/.tmux/skin.conf

shell:
	chsh -s `which zsh`

nvim:
	if [ ! -e /usr/bin/nvim ]; then \
		curl -fLo /tmp/nvim https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage; \
		chmod u+x /tmp/nvim; \
		sudo mv /tmp/nvim /usr/bin/nvim; \
	fi
	# TODO: create py3nvim and py2nvim virtual envs
	#       https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
	python3 -m pip install --user --upgrade pynvim
	pip2 install --user --upgrade pynvim

pyenv:
	if [ ! -d ~/.pyenv ]; then curl https://pyenv.run | bash; fi
