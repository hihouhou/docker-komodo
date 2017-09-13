#
# komodo Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

# Update & install packages for dependencies
RUN apt-get update && \
    apt-get install -y build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python zlib1g-dev wget bsdmainutils automake libboost-all-dev libssl-dev libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev libdb++-dev ntp ntpdate vim software-properties-common curl libcurl4-gnutls-dev cmake clang

# Install nanomsg
RUN git clone https://github.com/nanomsg/nanomsg && \
    cd nanomsg && \
    cmake . && \
    make && \
    make install && \
    ldconfig

# Install komodo
RUN cd / && \
    git clone https://github.com/jl777/komodo && \
    cd komodo && \
    git checkout beta && \
    ./zcutil/fetch-params.sh

# Add config file
RUN mkdir /root/.komodo
COPY komodo.conf /root/.komodo/komodo.conf

#Configure number of cpu used
#./zcutil/build.sh -j$(nproc)

