FROM ubuntu:14.04

MAINTAINER Rick Alm <rickalm@aol.com>

RUN locale-gen en_US en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    apt-get update -q && \
    apt-get upgrade -y -q && \
    apt-get dist-upgrade -y -q && \
    apt-get install -y software-properties-common python-software-properties && \
    echo "deb http://repo.pritunl.com/stable/apt trusty main" > /etc/apt/sources.list.d/pritunl.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A && \
    apt-get update -q && \
    apt-get install -y pritunl iptables && \
    apt-get clean && \
    apt-get -y -q autoclean && \
    apt-get -y -q autoremove && \
    rm -rf /tmp/*

ENTRYPOINT ["/bin/start-pritunl"]

ADD start-pritunl /bin/start-pritunl
