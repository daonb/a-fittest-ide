# Fittest-IDE Makefile for *NIX system. 
home = ~/.ide
lp_path = $(home)/liquidprompt
zsh_path := $(shell which zsh)
users_shell := $(shell getent passwd ${LOGNAME} | cut -d: -f7)

clean:
	rm -rf $(home)

$(home):
	mkdir $(home)

install: $(home) pyenv nvim shell tmux
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	cp config/init.vim ~/.config/nvim
	cp config/liquidpromptrc ~/.config
	git config --global core.editor "nvim"

shell: $(home)
	cp config/zshrc ~/.zshrc
	cp config/zsh_plugins.txt $(home)
	if [ "$(users_shell)" != "$(zsh_path)" ]; then \
		echo "Changing default shell to zsh"; \
		chsh -s $(zsh_path); \
	fi
	echo "now run 'exec $(zsh_path)'"

nvim:
	if [ ! -e /usr/bin/nvim ]; then \
		curl -fLo /tmp/nvim https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage; \
		chmod u+x /tmp/nvim; \
		sudo mv /tmp/nvim /usr/bin/nvim; \
	fi

pyenv:
	if [ ! -d ~/.pyenv ]; then curl https://pyenv.run | bash; fi

tmux:
	mkdir -p ~/.tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	cp config/tmux.conf ~/.tmux.conf
	# TODO: add a `skins` fodler
	cp config/tmux_skin.conf ~/.tmux/skin.conf
