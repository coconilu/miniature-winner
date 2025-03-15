# Docker 配置说明

本项目使用 Docker 来统一开发环境和生产环境，确保一致性和可移植性。

## 开发环境

在开发环境中，我们使用 `docker-compose.yml` 文件来配置和运行应用。

### 启动开发环境

```bash
# 构建并启动开发环境
docker-compose up -d

# 查看日志
docker-compose logs -f
```

开发环境的特点：

- 代码热重载：修改代码后自动重新加载
- 源代码挂载：本地代码变更会立即反映在容器中
- 依赖隔离：node_modules 在容器内部，不会与本地环境冲突

### 停止开发环境

```bash
docker-compose down
```

## 生产环境

生产环境使用 `docker-compose.prod.yml` 文件，它针对生产环境进行了优化。

### 启动生产环境

```bash
# 构建并启动生产环境
docker-compose -f docker-compose.prod.yml up -d

# 查看日志
docker-compose -f docker-compose.prod.yml logs -f
```

生产环境的特点：

- 多阶段构建：减小最终镜像大小
- 仅包含生产依赖：不包含开发工具
- 预构建的应用：直接运行构建后的代码，提高性能
- 自动重启：服务崩溃时自动重启

### 停止生产环境

```bash
docker-compose -f docker-compose.prod.yml down
```

## 自定义配置

如果需要自定义环境变量，可以创建 `.env` 文件，Docker Compose 会自动加载它。

示例 `.env` 文件：

```
NODE_ENV=production
API_URL=https://api.example.com
```

## 常见问题

### 端口冲突

如果遇到端口冲突，可以修改 docker-compose 文件中的端口映射：

```yaml
ports:
  - "3001:3000" # 将主机的 3001 端口映射到容器的 3000 端口
```

### 容器内执行命令

要在运行中的容器内执行命令：

```bash
# 开发环境
docker-compose exec app sh

# 生产环境
docker-compose -f docker-compose.prod.yml exec app sh
```

## 其他有用的 Docker 命令

### 查看运行中的容器

查看当前系统中所有正在运行的 Docker 容器：

```bash
docker ps
```

查看所有容器（包括已停止的）：

```bash
docker ps -a
```

### 查看容器日志

查看特定容器的日志输出：

```bash
docker logs <container_id>
```

实时查看日志（类似 tail -f）：

```bash
docker logs -f <container_id>
```

### 重启容器

重启所有服务：

```bash
docker-compose restart
```

重启特定服务：

```bash
docker-compose restart app
```

### 查看容器资源使用情况

实时监控所有容器的 CPU、内存、网络和存储使用情况：

```bash
docker stats
```

### 清理 Docker 资源

删除所有未使用的容器、网络、镜像和卷：

```bash
docker system prune -f
```

只删除未使用的镜像：

```bash
docker image prune -a
```

删除所有停止的容器：

```bash
docker container prune
```

### 依赖更新后重建容器

当更新了`package.json`或其他依赖文件后，需要重新构建容器：

```bash
docker-compose up -d --build
```

### 解决套接字文件冲突

如果遇到"address already in use"错误，可以尝试：

```bash
# 停止所有容器
docker-compose down

# 删除Nitro的临时文件（在WSL中执行）
rm -rf /tmp/nitro

# 重新构建并启动
docker-compose up -d --build
```
