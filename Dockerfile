## @file Dockerfile
# @brief Dockerfile for buildroot environment
#
# @copyright
# Copyright (c) 2017, Nick Knudson <nak.co>
# All rights reserved.
#
# @page License
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.

FROM ubuntu:16.04
MAINTAINER Nick Knudson <nak.co>
LABEL "co.nak.vendor"     ="nak.co" \
      "co.nak.name"       ="buildroot-docker" \
      "co.nak.description"="Buildroot Environment in Docker"
ADD LICENSE /root/LICENSE
ENV DOCKER YES

# update root password
RUN echo "root:root" | chpasswd

# set locale
RUN locale-gen en_US.UTF-8 && locale-gen --purge --lang en_US.UTF-8

# install packages
RUN apt-get update && apt-get install -y \
  # MANDATORY build tools
  #which \
  bc \
  sed \
  make \
  binutils \
  build-essential \
  gcc \
  g++ \
  bash \
  patch \
  gzip \
  bzip2 \
  perl \
  tar \
  cpio \
  python \
  unzip \
  rsync \
  # MANDATORY source fetching tools
  wget \
  # OPTIONAL configuration interface dependencies
  libncurses5-dev \
  libqt4-dev \
  libglib2.0-dev \
  libgtk2.0-dev \
  libglade2-dev \
  # OPTIONAL source fetching tools
  #bazaar \
  cvs \
  git \
  mercurial \
  rsync \
  liblscp-dev \
  subversion \
  # OPTIONAL java related packages
  javacc \
  jarwrapper \
  # OPTIONAL documentation generation tools
  asciidoc \
  w3m \
  python3 \
  dblatex \
  # OPTIONAL graph generation tools
  graphviz \
  python-matplotlib

# add user
RUN useradd -ms /bin/bash buildroot && usermod -a -G sudo buildroot && echo "buildroot:buildroot" | chpasswd

# set file ownership and user
RUN chown -R buildroot:buildroot /home/buildroot
USER buildroot
ENV HOME=/home/buildroot
