FROM ubuntu:14.04

RUN apt-get update && \
    apt-get dist-upgrade && \
    apt-get install -y software-properties-common

RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git

RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd

RUN apt-get install -y \
        build-essential \
        vim \
        tmux \
        ;
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


RUN sed -i 's/^%sudo.\+$/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers

RUN useradd -ms /bin/bash -G sudo kong
USER kong
    WORKDIR /home/kong
    RUN mkdir .ssh
    RUN mkdir data && \
        echo "data dir not mounted" > data/README
    COPY src/* ./
    RUN cat .bashrc.append >> .bashrc && rm .bashrc.append
USER root

EXPOSE 22
EXPOSE 80

CMD ["/usr/sbin/sshd", "-D"]
