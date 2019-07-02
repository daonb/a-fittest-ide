FROM ubuntu:bionic

# Locales
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8
# Colors and italics for tmux
COPY config/xterm-256color-italic.terminfo /root
RUN tic /root/xterm-256color-italic.terminfo
ENV TERM=xterm-256color-italic

# Common packages
RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      git  \
      iputils-ping \
      jq \
      libncurses5-dev \
      libevent-dev \
      net-tools \
      netcat-openbsd \
      software-properties-common \
      tmux \
      wget \
      zsh 
# Pyenv
RUN apt-get install -y make libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl
RUN curl https://pyenv.run | zsh
# Install pyenv and create venvs 
RUN /root/.pyenv/bin/pyenv install 2.7.15
RUN /root/.pyenv/bin/pyenv install 3.7.3
RUN /root/.pyenv/bin/pyenv virtualenv 2.7.15 afide2 &&\
        /root/.pyenv/versions/afide2/bin/pip install neovim
RUN /root/.pyenv/bin/pyenv virtualenv 3.7.3 afide3 &&\
        /root/.pyenv/versions/afide3/bin/pip install neovim jedi mistune psutil setproctitle
RUN chsh -s /usr/bin/zsh
# Install docker
RUN  curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&\
      chmod +x /usr/local/bin/docker-compose
# Install tmux
WORKDIR /usr/local/src
RUN wget https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz
RUN tar xzvf tmux-2.9.tar.gz
WORKDIR /usr/local/src/tmux-2.9
RUN ./configure
RUN make 
RUN make install
RUN rm -rf /usr/local/src/tmux*
# Install neovim
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update
RUN apt-get install -y neovim
# Install antibody
RUN curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
# Copy config, skin, etc
COPY . /root/.afide/
WORKDIR /root/.afide
CMD make install
