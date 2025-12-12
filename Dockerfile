FROM ghost:5-alpine

# 安裝 Cloudflare R2 Storage Adapter
RUN npm install ghost-storage-cloudflare-r2 && \
    mkdir -p /var/lib/ghost/content/adapters/storage && \
    cp -r node_modules/ghost-storage-cloudflare-r2 /var/lib/ghost/content/adapters/storage/cloudflare-r2

# 設定預設配置
COPY config.production.json /var/lib/ghost/config.production.json
