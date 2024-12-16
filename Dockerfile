FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN  apt update -y && \
    apt dist-upgrade -y && \
    apt  install -y wget make git unzip libc6-dev g++ gcc pkgconf  \
    build-essential cmake lz4 liblz4-dev 
#    apt-get clean autoclean && \
#    apt-get autoremove --yes

WORKDIR /opt
ENV LD_LIBRARY_PATH=/usr/local/lib

RUN wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz && \
    tar -xvf openssl-1.1.1n.tar.gz && \
    cd openssl-1.1.1n && \
    ./config && \
    make && \
    make install &&\
    ldconfig && \
    openssl version
    
ENV CMAKE_MODULE_DIR=/usr/share/cmake/Modules/
COPY FindAWSSDK.cmake /usr/share/cmake/Modules/
COPY FindAWSSDK.cmake /usr/share/cmake-3.22/Modules/

COPY FindAWSSDK.cmake /usr/share/cmake/Modules/

RUN apt install zlib1g zlib1g-dev libcurl4 libcurlpp0 libcurlpp-dev \
    libcurl4 libcurlpp-dev libcurl4-openssl-dev libcurlpp0 \
    linux-tools-aws-lts-22.04 linux-aws


CMD ["bash"]
