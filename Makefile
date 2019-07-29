# Fittest-IDE Makefile for *NIX system. 
home = $(shell pwd)
lp_path = $(home)/liquidprompt
backup_path = $(home)/backup_path
zsh_path := $(shell which zsh)

$(backup_path):
	mkdir -p $(backup_path)

install: $(backup_path) pyenv nvim zsh tmux antibody
	ln -s -f $(home)/config/liquidpromptrc ~/.config
	git config --global core.editor "nvim"

antibody:
	if [ ! -n "$(shell which antibody)" ]; then \
		curl -sfL git.io/antibody | sh -s - -b $(home)/bin; \
	fi

zsh:
	if [ ! -n "$(zsh_path)" ]; then \
		echo "You need to install zsh yourself :-("; \
	fi
	ln -s -f $(home)/config/zshrc ~/.zshrc

nvim:
	if [ ! -n /usr/bin/nvim ]; then \
		curl -sfLo /tmp/nvim https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage; \
		chmod u+x /tmp/nvim; \
		sudo mv /tmp/nvim /usr/local/bin/nvim; \
	fi
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s -f $(home)/config/init.vim ~/.config/nvim

pyenv:
	if [ ! -d ~/.pyenv ]; then curl -s https://pyenv.run | bash; fi

tmux:
	mkdir -p ~/.tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	ln -s -f $(home)/config/tmux.conf ~/.tmux.conf


docker-test: $(pyenv) $(zsh) $(tmux) $(nvim)
	nvim -es +checkhealth && echo "PASSED: nvim ':checkhealth' succesful"


test:
	echo "***WIP: test expected to fail and therfore undocumented ***"
	docker build -t afide .
	docker run afide make docker-test
