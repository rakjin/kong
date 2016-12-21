FROM ubuntu:16.04

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update
RUN apt-get install -y git

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN apt-get install -y build-essential

RUN apt-get install -y libreadline-dev
RUN apt-get install -y libsqlite3-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y zlib1g-dev

RUN apt-get install -y curl
RUN apt-get install -y man
RUN apt-get install -y silversearcher-ag
RUN apt-get install -y tig
RUN apt-get install -y tmux
RUN apt-get install -y vim
RUN apt-get install -y zsh

RUN apt-get install -y sudo
RUN sed -i 's/^%sudo.\+$/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers

RUN locale-gen en_US.UTF-8
RUN update-locale \
        LANG="en_US.UTF-8" \
        LC_CTYPE="en_US.UTF-8" \
        LC_NUMERIC="en_US.UTF-8" \
        LC_TIME="en_US.UTF-8" \
        LC_COLLATE="en_US.UTF-8" \
        LC_MONETARY="en_US.UTF-8" \
        LC_MESSAGES="en_US.UTF-8" \
        LC_PAPER="en_US.UTF-8" \
        LC_NAME="en_US.UTF-8" \
        LC_ADDRESS="en_US.UTF-8" \
        LC_TELEPHONE="en_US.UTF-8" \
        LC_MEASUREMENT="en_US.UTF-8" \
        LC_IDENTIFICATION="en_US.UTF-8" \
        ;

RUN useradd -ms /bin/zsh -G sudo kong
USER kong
    WORKDIR /home/kong
    RUN mkdir .ssh

    RUN mkdir volume
    RUN echo "dir not mounted" > volume/README
    VOLUME volume

USER root

COPY src/home/* /home/kong/
RUN chown kong:kong -R /home/kong
USER kong

    WORKDIR /home/kong

    # omz
    RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
    RUN cp .oh-my-zsh/templates/zshrc.zsh-template .zshrc
    RUN sed -i 's/^ZSH_THEME=.\+$/ZSH_THEME="sorin"/g' .zshrc
    RUN echo "source ~/.zshrc.append" >> .zshrc

    # rbenv
    RUN git clone https://github.com/sstephenson/rbenv.git .rbenv
    RUN git clone https://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build
    RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc.append
    RUN echo 'eval "$(rbenv init -)"'               >> ~/.zshrc.append
    RUN . ~/.zshrc.append && rbenv install 2.1.5
    RUN . ~/.zshrc.append && rbenv global 2.1.5
    RUN . ~/.zshrc.append && gem install bundler

    # pyenv
    RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    RUN echo 'export PYENV_ROOT="$HOME/.pyenv"'    >> ~/.zshrc.append
    RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc.append
    RUN echo 'eval "$(pyenv init -)"'              >> ~/.zshrc.append
    RUN . ~/.zshrc.append && pyenv install 2.7.12
    RUN . ~/.zshrc.append && pyenv install 3.5.2
    RUN . ~/.zshrc.append && pyenv global  3.5.2

    # nvm
    RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
    RUN echo 'export NVM_DIR="$HOME/.nvm"'                     >> ~/.zshrc.append
    RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zshrc.append
    RUN . ~/.zshrc.append && nvm install node

    # vim vundle
    RUN git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
    RUN vim +PluginInstall +qall > /dev/null 2>&1

    # tmuxinator
    RUN gem install tmuxinator

USER root

EXPOSE 22

# http://stackoverflow.com/a/18374381/3296566
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN echo 'kong:'$(openssl rand -base64 32) | chpasswd

CMD ["/usr/sbin/sshd", "-D"]
