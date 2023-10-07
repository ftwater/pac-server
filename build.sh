docker build -t pac-server-work . && docker run --name pac-server-work -d \
-p 80:80 \
-v /home/zhaoyanpeng/data-disk/docker-workspace/pac-server/home/work:/home/work \
-it pac-server-work