# Nuxt 3 项目 - Docker 开发环境

本项目使用 Docker 来统一开发环境和生产环境，确保一致性和可移植性，有效磨平了环境差异。

## 技术栈

- Nuxt 3
- Node.js 20.12.1
- pnpm 9.12.3
- Alpine Linux 基础镜像

## 为什么使用 Docker？

使用 Docker 容器化开发和部署流程提供了以下优势：

- **环境一致性**：开发、测试和生产环境完全一致，消除"在我机器上能运行"的问题
- **简化配置**：无需手动安装依赖或配置环境变量
- **隔离依赖**：避免全局安装带来的冲突
- **快速部署**：打包完整的运行环境，一键部署
- **团队协作**：所有团队成员使用相同的开发环境

## 快速开始

### 开发环境

```bash
# 构建并启动开发环境
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止开发环境
docker-compose down
```

### 生产环境

```bash
# 构建并启动生产环境
docker-compose -f docker-compose.prod.yml up -d

# 查看日志
docker-compose -f docker-compose.prod.yml logs -f

# 停止生产环境
docker-compose -f docker-compose.prod.yml down
```

## 主要开发命令

### 容器内执行命令

```bash
# 进入开发容器
docker-compose exec app sh

# 进入生产容器
docker-compose -f docker-compose.prod.yml exec app sh
```

### 常用操作

```bash
# 重启容器
docker-compose restart

# 重建容器（依赖更新后）
docker-compose up -d --build

# 查看容器状态
docker ps

# 查看容器资源使用
docker stats
```

### 日志查看

```bash
# 查看容器日志
docker logs <container_id>

# 实时查看日志
docker logs -f <container_id>
```

## 环境特点

### 开发环境优势

- 代码热重载：修改代码后自动重新加载
- 源代码挂载：本地代码变更会立即反映在容器中
- 依赖隔离：node_modules 在容器内部，不会与本地环境冲突
- 持久化卷：使用命名卷保存 node_modules 和 pnpm 缓存
- 构建缓存优化：使用 BuildKit 内联缓存加速重复构建

### 生产环境优势

- 多阶段构建：减小最终镜像大小
- 仅包含生产依赖：不包含开发工具
- 预构建的应用：直接运行构建后的代码，提高性能
- 自动重启：服务崩溃时自动重启
- 健康检查：定期检查应用是否正常运行

## 更多信息

查看 `docker-README.md` 了解更详细的 Docker 配置信息和高级用法。

查看 [Nuxt 3 文档](https://nuxt.com/docs/getting-started/introduction) 了解更多关于 Nuxt 框架的信息。
