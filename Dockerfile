FROM centos:7.6.1810

MAINTAINER Wenrui Ma <macomfan@163.com>

# Install GCC, OpenSSL, Curl, ssh, net-tools, git
RUN yum install -y centos-release-scl-rh centos-release-scl && \
    yum install -y devtoolset-3-gcc  devtoolset-3-gcc-c++ && \
    yum install -y openssl openssl-devel && \
    yum install -y libcurl libcurl-devel && \
    yum install -y openssh-server net-tools git && \
    yum clean all -y

# Install CMake v3.14.7
# COPY cmake-3.14.7-Linux-x86_64.sh /usr
RUN cd /usr &&\
    curl -O https://cmake.org/files/v3.14/cmake-3.14.7-Linux-x86_64.sh && \
    sh /usr/cmake-3.14.7-Linux-x86_64.sh --skip-license &&\
    rm -f /usr/cmake-3.14.7-Linux-x86_64.sh
ENV PATH=$PATH:/bin/:/usr/bin/
RUN source /opt/rh/devtoolset-3/enable

# Install libwebsockets v3.1
ADD libwebsockets-3.1.0.tar.gz /root
RUN source /opt/rh/devtoolset-3/enable && \
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

# Config SSH
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key &&\
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key && \
    echo "huobi" | passwd --stdin root

WORKDIR /root
COPY run.sh /usr/local/bin/run.sh
EXPOSE 22
ENTRYPOINT ["sh", "run.sh"]
