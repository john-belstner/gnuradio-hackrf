# Copyright (c) XPRIZE DevOps Team.
# Distributed under the terms of the MIT License.

ARG BASE_CONTAINER=ubuntu:bionic
FROM $BASE_CONTAINER

LABEL maintainer="John Belstner <jbelstner@gmail.com>"

USER root

# Install OS dependencies and Python3 only
RUN apt-get update \
    && apt-get upgrade -yq \
    && apt-get install -yq \
        dumb-init \
        host \
        locales \
        xterm \
        gnuradio \
        gnuradio-dev \
        gnuradio-doc \
        hackrf \
        libhackrf0 \
        libhackrf-dev \
        gr-osmosdr \
        libcanberra-gtk-module \
        libcanberra-gtk3-module \
    && apt-get clean \
    && apt-get autoremove -yq \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

RUN rm /usr/share/mime/packages/gnuradio.xml \
    && ln -s /usr/share/gnuradio/grc/freedesktop/gnuradio-grc.xml /usr/share/mime/packages/gnuradio.xml

# Configure environment
ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    HOME=/root

COPY grc.conf /etc/gnuradio/conf.d/grc.conf
COPY init /usr/local/bin/init

WORKDIR $HOME/work
ENTRYPOINT ["dumb-init"]
CMD ["init"]
