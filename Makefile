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

install: $(backup_path) pyenv nvim zsh tmux
	ln -s --backup=t $(home)/config/liquidpromptrc ~/.config
	echo "Installation is done. Please refresh your shell "

zsh: $(home)
	ln -s --backup=t $(home)/config/zshrc ~/.zshrc
	if [ "$(users_shell)" != "$(zsh_path)" ]; then \
		chsh -s $(zsh_path); \
	fi

docker-start: $(pyenv) $(zsh) $(tmux) $(nvim)
	ln -s --backup=t $(home)/config/liquidpromptrc ~/.config
	ln -s --backup=t $(home)/config/init.vim ~/.config/nvim
	tmux

docker:
	docker build -t afide .
	docker run -ti afide make docker-start

nvim:
	mkdir -p ~/.vim/autoload
	mkdir -p ~/.config/nvim
	[ ! -e ~/.local/share/nvim/site/autoload/plug.vim ] &&\
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s --backup=t $(home)/config/init.vim ~/.config/nvim
	git config --global core.editor "nvim"

pyenv:
	if [ ! -d ~/.pyenv ]; then curl https://pyenv.run | bash; fi

tmux:
	mkdir -p ~/.tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	ln -s --backup=t $(home)/config/tmux.conf ~/.tmux.conf
