#  A Fittest IDE

We provide a toolbox with smart, sharp tools that keep developers happy.
It is based on neovim, tmux, zsh and their open source extensions. 
VIM Plugins, shell frameworks and themes -we help you get started by bundling 
the best of bread.

When you install our IDE we will backup existing user conf files and 
link the files under `~/.afide/config` to their proper place:

    $ ll ~/.zshrc
    lrwxrwxrwx ... /home/daonb/.zshrc -> /home/daonb/.afide/config/zshrc

### Making Changes

If you want to change anything, go ahead. Just don't forget to reset:

* `exec zsh` when you change a `zsh*` file
* CTRL-aI for `tmux*` files
* `:source %` after changing your `init.vim`.

## Installation

### Debian/Ubuntu

First get the basic tools from distro packages (as root):

    apt get update
    apt get install neovim zsh tmux

Next, install antibody, pyenv, latest python and the virtual envs required:

    curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
    curl https://pyenv.run | zsh
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

Open a new `zsh` and enjoy the fruits of evolution.

### Unistalling
If you decide it's not for you just `afide uninstall` and we'll remove ourselvs and restore the config files. 

## Inspiration

* Dr. Bunsen: [The Text Triumvirate](https://www.drbunsen.org/the-text-triumvirate/)
* Jannis Hemanns: [The iPad Pro as main computer for programming](https://jann.is/ipad-pro-for-programming/)
* Doug Black: [Adding vim to your zsh](https://dougblack.io/words/zsh-vi-mode.html)
* Keggan Lowenstein: [Tmux and Vim - even better together](https://www.bugsnag.com/blog/tmux-and-vim)
* [vim-awesome](https://vimawesome.com/)
* [dotfiles](http://dotfiles.github.io/)
