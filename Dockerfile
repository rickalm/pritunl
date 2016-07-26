FROM ubuntu:14.04

MAINTAINER Rick Alm <rickalm@aol.com>

ENTRYPOINT ["/bin/start-pritunl"]

RUN \
    # Setup timezone as UTC; \
    \
    locale-gen en_US en_US.UTF-8 \
      || exit 1; \
    dpkg-reconfigure locales \
      || exit 1; \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
      || exit 1; \
    \
    # Make sure our image is up to date with patches; \
    \
    apt-get update -q \
      || exit 1; \
    apt-get upgrade -y -q \
      || exit 1; \
    apt-get dist-upgrade -y -q \
      || exit 1; \
    \
    # Install Python; \
    \
    apt-get install -y \
      software-properties-common \
      python-software-properties \
      || exit 1; \
    \
    # Add PriTunl Repo to APT Sources; \
    \
    echo "deb http://repo.pritunl.com/stable/apt trusty main" > /etc/apt/sources.list.d/pritunl.list \
      || exit 1; \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A \
      || exit 1; \
    apt-get update -q \
      || exit 1; \
    \
    # install PriTunl and tools it needs; \
    \
    apt-get install -y \
      pritunl \
      iptables \
      curl \
      || exit 1; \
    \
    # Use Python compileall to take all .py and create .pyc files; \
    # Improves docker use of overlayFS; \
    # Confirm PruTunl is installed; \
    \
    python -m compileall /usr/lib/pritunl \
      || exit 1; \
    pritunl version \
      || exit 1; \
    \
    # Clean up all the tmp files that got created; \
    \
    apt-get clean \
      || exit 1; \
    apt-get -y -q autoclean \
      || exit 1; \
    apt-get -y -q autoremove \
      || exit 1; \
    rm -rf /tmp/* \
      || exit 1; \
    \
    /bin/true

ADD start-pritunl /bin/start-pritunl
