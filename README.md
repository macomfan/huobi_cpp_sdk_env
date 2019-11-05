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