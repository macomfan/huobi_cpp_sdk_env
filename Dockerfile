FROM centos:7.6.1810

MAINTAINER Wenrui Ma <macomfan@163.com>

# Install system tools
RUN yum install -y zip unzip which

# Install openssl ssh
RUN yum install -y openssl openssl-devel && \
    yum install -y openssh-server net-tools && \
    yum clean all -y

# Config ssh
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key &&\
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key && \
    echo "huobi" | passwd --stdin root

# Install devtoolset-3
RUN yum install -y centos-release-scl-rh centos-release-scl && \
    yum install -y devtoolset-3-gcc  devtoolset-3-gcc-c++ gdb && \
    yum clean all -y

# Install curl git
RUN yum install -y libcurl libcurl-devel && \
    yum install -y git && \
    yum clean all -y

# Install CMake v3.14.7
RUN cd /usr &&\
    curl -O https://cmake.org/files/v3.14/cmake-3.14.7-Linux-x86_64.sh && \
    sh /usr/cmake-3.14.7-Linux-x86_64.sh --skip-license &&\
    rm -f /usr/cmake-3.14.7-Linux-x86_64.sh
ENV PATH=$PATH:/bin/:/usr/bin/

# Install libwebsockets v3.1
RUN source /opt/rh/devtoolset-3/enable && \
    git clone --branch v3.1.0 https://github.com/warmcat/libwebsockets.git /root/libwebsockets-3.1.0 &&\
    cd /root/libwebsockets-3.1.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd .. && rm -rf build

# Install decnumber
ADD libdecnumber.tar.gz /root
RUN source /opt/rh/devtoolset-3/enable && \
    cd /root/libdecnumber && \
    mkdir build && \
    cd build && \
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
    make && make install && \
    cd .. && rm -rf build

# Install gtest
RUN source /opt/rh/devtoolset-3/enable && \
    git clone --branch release-1.8.0 https://github.com/google/googletest.git /root/googletest-1.8.0 && \
    cd /root/googletest-1.8.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd .. && rm -rf build

WORKDIR /root
COPY run.sh /usr/local/bin/run.sh
RUN echo "source /opt/rh/devtoolset-3/enable" >> /root/.bashrc

EXPOSE 22
ENTRYPOINT ["sh", "run.sh"]
