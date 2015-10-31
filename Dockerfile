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
        LC_ALL="en_US.UTF-8"

RUN apt-get install -y \
        build-essential \
        curl \
        libsqlite3-dev \
        tmux \
        vim \
        ;

RUN sed -i 's/^%sudo.\+$/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers

RUN apt-get install -y zsh
RUN useradd -ms /bin/zsh -G sudo kong
COPY src/home/* /home/kong/
RUN chown kong:kong -R /home/kong
USER kong
    WORKDIR /home/kong
    RUN mkdir .ssh
    RUN mkdir volume && \
        echo "dir not mounted" > volume/README
    VOLUME volume
    RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh && \
        cp .oh-my-zsh/templates/zshrc.zsh-template .zshrc && \
        sed -i 's/^ZSH_THEME=.\+$/ZSH_THEME="sorin"/g' .zshrc && \
        cat .zshrc.append >> .zshrc && \
        rm .zshrc.append
    RUN git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim && \
        vim +PluginInstall +qall > /dev/null 2>&1
USER root

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
