FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root/

# Tools & Utils
RUN apt-get update && \
    apt-get install -y \
      curl \
      git \
      htop \
      ncdu \
      tmux \
      vim \
      wget \
      zip \
      zsh

# AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    rm awscliv2.zip && \
    ./aws/install

# Clojure
RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jdk \
      rlwrap && \
      curl -o- https://download.clojure.org/install/linux-install-1.10.3.1040.sh | bash
      
# Golang
RUN wget -O go.tar.gz https://go.dev/dl/go1.17.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz
      
# Java
  # Already installed by Clojure...

# JavaScript (NodeJS & NPM)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs

# Python
RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-pip

ENTRYPOINT ["tail", "-f", "/dev/null"]
