#  Fittest-IDE 

### A repo dedicated to a vi-zsh-tmux-etc IDE

## Installation

### Debian/Ubuntu

First get the basic tools from distro packages (as root):

    apt get update
    apt get install neovim zsh tmux

Next, install antibody, pyenv, latest python and the virtual envs required:

    curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
    curl https://pyenv.run | zsh
    exec "SHELL"
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    exec "SHELL"
    pyenv install 2.7.15
    pyenv install 3.7.3
    pyenv virtualenv 2.7.15 mfi2
    pyenv activate mfi2 && pip install neovim
    pyenv virtualenv 3.7.3 mfi3
    pyenv activate mfi3 && pip install neovim
    git clone https://github.com/the-fittest-ide/my-fittest-ide.git
    cd my-fittest-de
    make install

Open a new termianl and enjoy the fruits of evolution.

## Inspiration

* Dr. Bunsen: [The Text Triumvirate](https://www.drbunsen.org/the-text-triumvirate/)
* Jannis Hemanns: [The iPad Pro as main computer for programming](https://jann.is/ipad-pro-for-programming/)
* Doug Black: [Adding vim to your zsh](https://dougblack.io/words/zsh-vi-mode.html)

## Sites

* [vim-awesome](https://vimawesome.com/)

* [dotfiles](http://dotfiles.github.io/)
