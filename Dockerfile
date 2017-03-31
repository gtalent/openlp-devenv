FROM debian:8

RUN apt-get update
RUN apt-get upgrade -y

###############################################################################
# Set locale

RUN apt-get install -y locales locales-all
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

###############################################################################
# Install gosu

RUN apt-get install -y curl
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" && \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu

###############################################################################
# Setup working directory

RUN mkdir /usr/src/project
WORKDIR /usr/src/project

###############################################################################
# Install dev tools

RUN apt-get install -y bzr vim python3-pip qttools5-dev-tools pyqt5-dev-tools python3-pyqt5 python3-pyqt5.qtmultimedia \
                       python3-pyqt5.qtsvg python3-pyqt5.qtwebkit python3-pyqt5.qtopengl python3-sqlalchemy \
                       python3-chardet python3-lxml python3-enchant python3-bs4 python3-mako python3-uno \
                       python3-nose python3-pip python3-alembic python3-xdg python3-dbus.mainloop.pyqt \
                       python3-pep8 python3-mediainfodll pylint

RUN pip3 install jenkins-webapi

###############################################################################
# Setup entrypoint

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
