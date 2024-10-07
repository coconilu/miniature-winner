#!/bin/bash

# 配置阿里云 OSS
ossutil config -e oss-cn-beijing.aliyuncs.com -i LTAI5tJmh1hn7aFj6P442nWz -k KDWIRC60J10rppbDmAh8t6CJArWzIw

# 下载压缩包
ossutil cp oss://nuxt3-server-pack/output.tar.gz /demo-server/

# 解压压缩包
# unzip /demo-server/archive.zip -d /demo-server/
tar -xzvf /demo-server/output.tar.gz -C /demo-server/

# 移动文件夹
mv /demo-server/.output/* /demo-server/
rmdir /demo-server/.output

# 安装项目依赖
# cd /app/your-project-directory
# npm install

# 使用 pm2 启动项目
pm2 start server/index.mjs --name "nuxt-demo-server"
pm2 logs