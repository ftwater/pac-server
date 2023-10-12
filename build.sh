#!/bin/bash

# 定义一个函数，对输入的字符串参数打印，颜色为绿色
print_green() {
    echo -e "\033[32m$1\033[0m"
}
# 定义一个函数，对输入的字符串参数打印，颜色为灰色
print_gray() {
    echo -e "\033[90m$1\033[0m"
}

# 将当前目录作为工作目录
init_variables() {
    cd "$(dirname "$0")"
    CURRENT_DIR="$(pwd)"
    print_green "当前工作目录 CURRENT_DIR:$(pwd)"

    DOCKERFILE_PATH="${CURRENT_DIR}/Dockerfile"
    WORKDIR_PATH="${CURRENT_DIR}/home/work"
    IMAGE_NAME="pac-server-work"
    CONTAINER_NAME="pac-server-work"

    print_gray "IMAGE_NAME: ${IMAGE_NAME}"
    print_gray "CONTAINER_NAME: ${CONTAINER_NAME}"
    print_gray "DOCKERFILE_PATH: ${DOCKERFILE_PATH}"
    print_gray "WORKDIR_PATH: ${WORKDIR_PATH}"
}

# 定义构建 Docker 镜像的函数
build_image() {
    print_green "开始构建 Docker 镜像..."
    # 使用 Dockerfile 构建镜像
    docker build -t ${IMAGE_NAME} -f ${DOCKERFILE_PATH} . | while read line; do clear; tput cuu1; tput el; echo $line; done
}

# 定义停止并删除已有的 Docker 容器的函数
stop_and_remove_container() {
    print_green "停止并删除已有的 Docker 容器..."
    # 如果容器已经存在，停止并删除容器
    if docker ps -a | grep -q ${CONTAINER_NAME}; then
        docker stop ${CONTAINER_NAME}
        docker rm ${CONTAINER_NAME}
    fi
}

# 定义启动 Docker 容器的函数
start_container() {
    print_green "启动 Docker 容器..."
    # 运行容器并映射端口和挂载工作目录
    docker run -d \
        --name ${CONTAINER_NAME} \
        -p 80:80 \
        -v ${WORKDIR_PATH}:/home/work \
        ${IMAGE_NAME}
}

# 主函数
main() {
    # 构建镜像、停止并删除容器、启动容器
    init_variables && \
    build_image && \
    stop_and_remove_container && \
    start_container
}
# 调用主函数
main