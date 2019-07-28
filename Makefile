# Fittest-IDE Makefile for *NIX system. 
home = $(shell pwd)
lp_path = $(home)/liquidprompt
backup_path = $(home)/backup_path
zsh_path := $(shell which zsh)

$(backup_path):
	mkdir -p $(backup_path)

install: $(backup_path) pyenv nvim shell tmux
	ln -s -f $(home)/config/liquidpromptrc ~/.config
	git config --global core.editor "nvim"

shell: $(home)
	ln -s -f $(home)/config/zshrc ~/.zshrc
	echo "now run 'exec $(zsh_path)'"

nvim:
	if [ ! -e /usr/bin/nvim ]; then \
		curl -fLo /tmp/nvim https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage; \
		chmod u+x /tmp/nvim; \
		sudo mv /tmp/nvim /usr/local/bin/nvim; \
	fi
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s -f $(home)/config/init.vim
pyenv:
	if [ ! -d ~/.pyenv ]; then curl https://pyenv.run | bash; fi

tmux:
	mkdir -p ~/.tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	ln -s -f $(home)/config/tmux.conf ~/.tmux.conf


docker-test: $(pyenv) $(zsh) $(tmux) $(nvim)
	echo "checkhealth" | nvim -V1 -es -u ~/.config/nvim/init.vim


test:
	echo "***WIP: test expected to fail and therfore undocumented ***"
	docker build -t afide .
	docker run afide make docker-test
