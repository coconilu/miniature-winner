# 构建阶段
FROM node:20.12.1-alpine AS build

# 设置工作目录
WORKDIR /app

# 安装pnpm
RUN corepack enable && corepack prepare pnpm@9.12.3 --activate

# 设置 pnpm 存储位置
ENV PNPM_HOME="/pnpm-store"
RUN mkdir -p $PNPM_HOME

# 复制package.json和pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./
COPY .npmrc ./

# 安装依赖，使用挂载的缓存卷
RUN --mount=type=cache,target=/pnpm-store \
    pnpm config set store-dir /pnpm-store && \
    pnpm install --frozen-lockfile

# 复制源代码
COPY . .

# 构建应用
RUN pnpm build

# 开发阶段
FROM node:20.12.1-alpine AS dev

# 设置工作目录
WORKDIR /app

# 安装pnpm
RUN corepack enable && corepack prepare pnpm@9.12.3 --activate

# 设置 pnpm 存储位置
ENV PNPM_HOME="/pnpm-store"
RUN mkdir -p $PNPM_HOME

# 复制package.json和pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./
COPY .npmrc ./

# 安装所有依赖（包括开发依赖），使用挂载的缓存卷
RUN --mount=type=cache,target=/pnpm-store \
    pnpm config set store-dir /pnpm-store && \
    pnpm install --frozen-lockfile

# 复制源代码
COPY . .

# 设置环境变量
ENV NODE_ENV=development

# 暴露端口
EXPOSE 3000

# 启动开发服务器
CMD ["pnpm", "dev"]

# 生产阶段
FROM node:20.12.1-alpine AS production

WORKDIR /app

# 安装pnpm
RUN corepack enable && corepack prepare pnpm@9.12.3 --activate

# 设置 pnpm 存储位置
ENV PNPM_HOME="/pnpm-store"
RUN mkdir -p $PNPM_HOME

# 复制package.json和pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./
COPY .npmrc ./

# 仅安装生产依赖，使用挂载的缓存卷
RUN --mount=type=cache,target=/pnpm-store \
    pnpm config set store-dir /pnpm-store && \
    pnpm install --frozen-lockfile --prod

# 从构建阶段复制构建产物
COPY --from=build /app/.output ./.output

# 设置环境变量
ENV NODE_ENV=production

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["node", ".output/server/index.mjs"] 