FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root/

# Install Tools & Utils
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

# Setup Dotfiles
RUN curl -L -o- https://raw.githubusercontent.com/MitchTalmadge/dotfiles/master/bin/setup.sh | bash

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    rm awscliv2.zip && \
    ./aws/install

# Install Clojure
RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jdk \
      rlwrap && \
      curl -o- https://download.clojure.org/install/linux-install-1.10.3.1040.sh | bash
      
# Install Golang
RUN wget -O go.tar.gz https://go.dev/dl/go1.17.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz && \
    /usr/local/go/bin/go install \
      github.com/go-delve/delve/cmd/dlv@latest  \
      github.com/ramya-rao-a/go-outline@latest \
      github.com/fatih/gomodifytags@latest \
      github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest \
      github.com/haya14busa/goplay/cmd/goplay@latest \
      golang.org/x/tools/gopls@latest \
      github.com/cweill/gotests/gotests@latest \
      github.com/josharian/impl@latest \
      honnef.co/go/tools/cmd/staticcheck@latest
      
# Install Java
  # Already installed by Clojure...

# Install JavaScript (NodeJS & NPM)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs

# Install Python
RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-pip

ENTRYPOINT ["tail", "-f", "/dev/null"]
