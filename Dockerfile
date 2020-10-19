# Based on https://github.com/andresriancho/w3af.git

# • Updated dependency requirements
# • Striped install to fasten builds on Dockerfile design

FROM ubuntu:18.04

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    apt-utils \
    git \
    python \
    python-pip \
    python-gtk2-dev \
    npm \
    libxml2-dev \
    libxslt1-dev \
    graphviz \
    wget \
    libyaml-dev \
    libsqlite3-dev && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y sudo python3.7 && \
    git clone --depth 1 https://github.com/andresriancho/w3af.git && \
    npm install -g retire && \
    ./w3af/w3af_console || : && \
    pip3 install pyrsistent==0.16.1 && \
    /tmp/w3af_dependency_install.sh || : \
    wget http://ftp.cn.debian.org/debian/pool/main/p/python-support/python-support_1.0.15_all.deb && \
    dpkg -i python-support_1.0.15_all.deb || apt-get install -fy && \
    apt --fix-broken install && \
    wget http://ftp.cn.debian.org/debian/pool/main/p/pywebkitgtk/python-webkit_1.1.8-3_amd64.deb && \
    dpkg -i python-webkit_1.1.8-3_amd64.deb || apt-get install -fy && \
    apt --fix-broken install && \
    wget http://ftp.cn.debian.org/debian/pool/main/p/pywebkitgtk/python-webkit-dev_1.1.8-3_all.deb && \
    dpkg -i python-webkit-dev_1.1.8-3_all.deb || apt-get install -fy && \
    apt --fix-broken install && \
    cd /opt/w3af && \
    ls -la && \
    /opt/w3af/w3af_console || \
    /tmp/w3af_dependency_install.sh
    
WORKDIR /opt/w3af/

