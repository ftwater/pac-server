# 从官方nginx镜像构建
FROM nginx
# 将本地文件夹中的pac-server.conf配置文件拷贝到容器中的nginx虚拟主机配置目录中
COPY ./pac-server.conf /etc/nginx/conf.d/pac-server.conf
# 复制对/pac-server的反向代理配置
COPY ./default.conf /etc/nginx/conf.d/default.conf
# 设置服务器时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 工作目录设置
WORKDIR /home/work
# 挂载 /home/root作为工作目录
VOLUME /home/work
# 暴露80端口
EXPOSE 80
# 启动nginx服务
CMD ["nginx", "-g", "daemon off;"]

