#  Instlfittest-ide

### A repo dedicated to a vi-zsh-tmux-etc IDE, the fittest of them all!

## Installation

### Debian

```bash
sudo apt install zsh curl tmux neovim
cp plugins/plug.vim ~/.vim/autoload
cp config/init.vim ~/.config/nvim
cp config/liquidpromptrc ~/.config
cp config/tmux.conf ~/.tmux.conf
cp config/zshrc ~/.zshrc
# Add "git lg"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

TODO: liquidprompt install and instructions

