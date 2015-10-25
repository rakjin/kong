FROM ubuntu:14.04

RUN apt-get update && \
    apt-get dist-upgrade && \
    apt-get install -y software-properties-common

RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git

RUN apt-get install -y \
        openssh-server && \
    mkdir /var/run/sshd

RUN apt-get install -y \
        vim \
        tmux \
    ;

RUN useradd -ms /bin/bash kong
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
