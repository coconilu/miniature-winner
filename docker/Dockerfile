# 使用 Node.js 的官方镜像
FROM node:20.17.0

# RUN npm config set registry https://registry.npm.taobao.org
# RUN npm config set strict-ssl false

# 安装 pm2
RUN npm install -g pm2

# 安装阿里云 OSS 工具 ossutil
RUN curl -O http://gosspublic.alicdn.com/ossutil/1.7.9/ossutil64 && \
    chmod +x ossutil64 && \
    mv ossutil64 /usr/local/bin/ossutil

# 创建工作目录
WORKDIR /demo-server

# 将启动脚本复制到容器中
COPY start.sh /start.sh

# 给启动脚本执行权限
RUN chmod +x /start.sh

# 容器启动时执行启动脚本
CMD ["/start.sh"]