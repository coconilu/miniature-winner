#!/bin/bash

# 配置阿里云 OSS
ossutil config -e oss-cn-beijing.aliyuncs.com -i LTAI5tJmh1hn7aFj6P442nWz -k KDWIRC60J10rppbDmAh8t6CJArWzIw

# 下载压缩包
ossutil cp oss://nuxt3-server-pack/output.tar.gz /demo-server/

# 解压压缩包
# unzip /demo-server/archive.zip -d /demo-server/
tar -xzvf /demo-server/output.tar.gz -C /demo-server/

# pm2 检查进程是否存在并停止该进程
if pm2 list | grep -q "nuxt-demo-server"; then
    pm2 stop nuxt-demo-server
fi

# 检查并创建目录 /demo-server/output
mkdir -p /demo-server/output

# 删除旧文件
rm -rf /demo-server/output/*

# 移动文件夹
mv /demo-server/.output/* /demo-server/output/
rmdir /demo-server/.output

# 安装项目依赖
# cd /app/your-project-directory
# npm install

# 使用 pm2 启动项目
pm2 start output/server/index.mjs --name "nuxt-demo-server"
pm2 logs
