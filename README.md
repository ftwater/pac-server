# pac-server

## Introduction

docker 构建一个pac-server，提供pac文件给系统自动代理使用

## Usage

 1.构建镜像

```bash
./build.sh
```

2.启动容器

```bash
docker build -t pac-server . && docker run --name pac-server -d \
-p 8080:80 \
-v /var/log/nginx:/var/log/nginx \
-it pac-server
```

3.访问pac文件

```http
http://127.0.0.1/pac-server/auto_switch.pac
```
