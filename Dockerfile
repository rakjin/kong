FROM ubuntu:14.04

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y software-properties-common

RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git

RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd

RUN locale-gen en_US.UTF-8 && \
    update-locale \
        LANG="en_US.UTF-8" \
        LANGUAGE="en_US.UTF-8" \
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

RUN apt-get install -y \
        build-essential \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev \
        libsqlite3-dev \
        curl \
        tmux \
        vim \
        tig \
        ;

RUN sed -i 's/^%sudo.\+$/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers

RUN apt-get install -y zsh
RUN useradd -ms /bin/zsh -G sudo kong
USER kong
    WORKDIR /home/kong
    RUN mkdir .ssh
    RUN mkdir volume && \
        echo "dir not mounted" > volume/README
    VOLUME volume
    RUN git clone https://github.com/sstephenson/rbenv.git .rbenv && \
        git clone https://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build && \
        export PATH="$HOME/.rbenv/bin:$PATH" && \
        eval "$(rbenv init -)" && \
        rbenv install 2.1.5 && \
        rbenv global 2.1.5 && \
        gem install bundler
USER root

COPY src/home/* /home/kong/
RUN chown kong:kong -R /home/kong
USER kong
    WORKDIR /home/kong
    RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh && \
        cp .oh-my-zsh/templates/zshrc.zsh-template .zshrc && \
        sed -i 's/^ZSH_THEME=.\+$/ZSH_THEME="sorin"/g' .zshrc && \
        cat .zshrc.append >> .zshrc && \
        rm .zshrc.append
    RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash && \
        export NVM_DIR="$HOME/.nvm" && \
        . .nvm/nvm.sh && \
        nvm install node
    RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc && \
        echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    RUN git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim && \
        vim +PluginInstall +qall > /dev/null 2>&1
USER root

EXPOSE 22

# http://stackoverflow.com/a/18374381/3296566
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN echo 'kong:kokokong' | chpasswd

CMD ["/usr/sbin/sshd", "-D"]
