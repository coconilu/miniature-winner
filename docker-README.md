# Docker 配置说明

本项目使用 Docker 来统一开发环境和生产环境，确保一致性和可移植性。

## 项目技术栈

- Node.js 20.12.1
- pnpm 9.12.3
- Alpine Linux 基础镜像

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
- 持久化卷：使用命名卷保存 node_modules 和 pnpm 缓存
- 端口映射：将容器的 3000 端口映射到主机的 7566 端口
- 构建缓存优化：使用 BuildKit 内联缓存加速重复构建

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
- 健康检查：定期检查应用是否正常运行
- 端口映射：将容器的 3000 端口映射到主机的 7566 端口
- 构建缓存优化：使用 BuildKit 内联缓存加速重复构建

### 停止生产环境

```bash
docker-compose -f docker-compose.prod.yml down
```

## Docker 构建阶段

Dockerfile 使用多阶段构建优化镜像大小和构建效率：

1. **deps**: 安装所有依赖（包括开发依赖）
2. **deps-prod**: 仅安装生产依赖
3. **build**: 构建应用
4. **dev**: 开发环境镜像
5. **production**: 生产环境镜像

## 构建优化

项目使用了多种技术来优化 Docker 构建过程：

### BuildKit 内联缓存

配置文件中的 `BUILDKIT_INLINE_CACHE: 1` 参数启用了 BuildKit 的内联缓存功能，它有以下优势：

- 加速重复构建：重用之前构建的缓存层
- 减少网络传输：在推送和拉取镜像时包含缓存元数据
- 提高团队协作效率：团队成员可以共享构建缓存

### 缓存挂载

Dockerfile 中使用了 `--mount=type=cache` 指令来缓存 pnpm 依赖，避免每次构建都重新下载依赖包。

## 持久化存储

项目使用命名卷来持久化存储：

- **node_modules**: 持久化 node_modules 目录
- **pnpm_store**: 持久化 pnpm 缓存

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
