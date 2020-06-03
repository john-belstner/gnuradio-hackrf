# Copyright (c) XPRIZE DevOps Team.
# Distributed under the terms of the MIT License.

ARG BASE_CONTAINER=debian:buster
FROM $BASE_CONTAINER

LABEL maintainer="John Belstner <jbelstner@gmail.com>"

USER root

# Install OS dependencies and Python3 only
RUN apt-get update \
    && apt-get upgrade -yq \
    && apt-get install -yq \
        dumb-init \
        host \
        sudo \
        locales \
        rsync \
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

# Configure environment
ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    HOME=/root

COPY init /usr/local/bin/init

WORKDIR $HOME/work
ENTRYPOINT ["dumb-init"]
CMD ["init"]
