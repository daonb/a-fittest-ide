# Fittest-IDE Makefile for *NIX system. 
home = $(shell pwd)
lp_path = $(home)/liquidprompt
backup_path = $(home)/backup_path
zsh_path := $(shell which zsh)
users_shell := $(shell getent passwd ${LOGNAME} | cut -d: -f7)

clean:
	rm -rf $(home)

$(backup_path):
	mkdir -p $(backup_path)

install: $(backup_path) pyenv nvim shell tmux
	ln -sb $(home)/config/liquidpromptrc ~/.config
	git config --global core.editor "nvim"

shell: $(home)
	ln -sb $(home)/config/zshrc ~/.zshrc
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
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -sb $(home)/config/init.vim 

pyenv:
	if [ ! -d ~/.pyenv ]; then curl https://pyenv.run | bash; fi

tmux:
	mkdir -p ~/.tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	ln -sb $(home)/config/tmux.conf ~/.tmux.conf
