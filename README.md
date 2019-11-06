## Huobi CPP SDK development environment

### Overview
It is based on CentOS 7.6.1810  

Installed:
* devtoolset-3 (gcc v4.9.2)  
* openssl  
* curl  
* CMake v3.14.7  
* libwebsockets v3.1  
* libdecnumber
* git
* ssh

### Build tool collections
* gcc : /opt/rh/devtoolset-3/root/bin/gcc
* g++ : /opt/rh/devtoolset-3/root/bin/g++
* as : /usr/bin/as
* make : /usr/bin/make
* gdb : /usr/bin/gdb
* cmake : /usr/bin/cmake

### Usage

#### Pull form docker hub
```
docker pull macomfan/huobi_cpp_sdk_env
```

#### Start the container
```
docker run -it -v <Your local folder>:<Container folder> -p <Your local IP>:<Port>:22 macomfan/huobi_cpp_sdk_env
```

#### Connect the container via SSH
```
ssh root@<Your local IP> -p <Port>
```
Please use root as the login name and the password is "huobi" (quotation mark is not included)

### Guide to build
This is the guide to show how to build huobi cpp SDK and run a example to get candlestick data.

In your docker host box
```
# cd ~
# git clone --branch 1.0.5 https://github.com/HuobiRDCenter/huobi_Cpp.git huobi_cpp_1.0.5
# docker pull macomfan/huobi_cpp_sdk_env
# docker run -it -v ~:/root/hostbox -p 0.0.0.0:22222:22 macomfan/huobi_cpp_sdk_env
```
In the container box
```
[root@05b3854c5396 ~] cd /root/hostbox/huobi_cpp_1.0.5
[root@05b3854c5396 ~] mkdir build && cd build
[root@05b3854c5396 ~] cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
[root@05b3854c5396 ~] make && make install

[root@05b3854c5396 ~] cd /root/hostbox/huobi_cpp_1.0.5/examples/GetCandlestickData
[root@05b3854c5396 ~] mkdir build && cd build
[root@05b3854c5396 ~] cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
[root@05b3854c5396 ~] make
[root@05b3854c5396 ~] ./GetCandlestickData
```