FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root/

# Install Tools & Utils
RUN apt-get update && \
    apt-get install -y \
      curl \
      git \
      htop \
      ncdu \
      openssh-server \
      tmux \
      vim \
      wget \
      zip \
      zsh

# Copy Services
COPY ./services.d/ /etc/services.d/

# Setup SSH Server
RUN mkdir -p /var/run/sshd \
    && chmod 0755 /var/run/sshd

# Setup Dotfiles
RUN curl -L -o- https://raw.githubusercontent.com/MitchTalmadge/dotfiles/master/bin/setup.sh | bash \
    && sh /root/.dotfiles/bin/ssh/authorize_keys.sh

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    rm awscliv2.zip && \
    ./aws/install

# Install C/C++
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      clang \
      clang-format \
      clang-tidy \
      clang-tools \
      cmake

# Install Clojure
RUN apt-get update && \
    apt-get install -y \
      leiningen \
      openjdk-17-jdk \
      rlwrap && \
      curl -o- https://download.clojure.org/install/linux-install-1.10.3.1040.sh | bash
      
# Install Golang
RUN wget -O go.tar.gz https://go.dev/dl/go1.17.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz && \
    # dlv
    /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest && \
    # go-outline
    /usr/local/go/bin/go install github.com/ramya-rao-a/go-outline@latest && \
    # gomodifytags
    /usr/local/go/bin/go install github.com/fatih/gomodifytags@latest && \
    # gopkgs
    /usr/local/go/bin/go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest && \
    # goplay
    /usr/local/go/bin/go install github.com/haya14busa/goplay/cmd/goplay@latest && \
    # gopls
    /usr/local/go/bin/go install golang.org/x/tools/gopls@latest && \
    # gotests
    /usr/local/go/bin/go install github.com/cweill/gotests/gotests@latest && \
    # impl
    /usr/local/go/bin/go install github.com/josharian/impl@latest && \
    # staticcheck
    /usr/local/go/bin/go install honnef.co/go/tools/cmd/staticcheck@latest
      
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