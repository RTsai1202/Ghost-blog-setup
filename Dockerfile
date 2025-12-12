FROM ghost:6-alpine

# 安裝必要工具
RUN apk add --no-cache git

# 使用 cinntiq 的 adapter（確認可用）
RUN mkdir -p /var/lib/ghost/content/adapters/storage && \
    cd /var/lib/ghost/content/adapters/storage && \
    git clone https://github.com/cinntiq/ghost-storage-cloudflare-r2.git cloudflare-r2 && \
    cd cloudflare-r2 && \
    npm install --omit=dev
