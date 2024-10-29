# 普通镜像构建，随系统版本构建 amd/arm
docker build -t yangzihe/big-market-app:1.0 -f ./Dockerfile .
#docker build -t yangzihe/big-market-app:1.0 -f .\Dockerfile .
# 兼容 amd、arm 构建镜像
# docker buildx build --load --platform liunx/amd64,linux/arm64 -t xiaofuge/xfg-frame-archetype-app:1.0 -f ./Dockerfile . --push
# 使用 buildx 构建多平台镜像
#docker buildx build --platform linux/amd64,linux/arm64 -t xiaofuge/xfg-frame-arch --push .