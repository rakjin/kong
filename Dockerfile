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

RUN useradd -ms /bin/bash kong && \
    mkdir /home/kong/.ssh


EXPOSE 22
EXPOSE 80

CMD ["/usr/sbin/sshd", "-D"]
