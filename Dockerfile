FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Tools & Utils
RUN apt-get update && \
    apt-get install -y \
      curl \
      htop \
      ncdu \
      tmux \
      wget \
      zsh

# Clojure
RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jdk \
      rlwrap && \
      curl -o- https://download.clojure.org/install/linux-install-1.10.3.1040.sh | bash
      
# Java
  # Already installed by Clojure...

# JavaScript
  # NodeJS
  RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
      apt-get update && \
      apt-get install -y nodejs

# Python
RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-pip

ENTRYPOINT ["tail", "-f", "/dev/null"]
