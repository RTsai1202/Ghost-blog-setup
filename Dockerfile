# 1. 使用 Ghost 6 的官方輕量版
FROM ghost:6-alpine

# 2. 安裝讓 Ghost 看得懂 Cloudflare R2 的外掛 (S3 Adapter)
WORKDIR /var/lib/ghost
RUN npm install ghost-storage-adapter-s3 && \
    mkdir -p ./content/adapters/storage/s3 && \
    cp -r ./node_modules/ghost-storage-adapter-s3/* ./content/adapters/storage/s3/

# 3. 啟動 Ghost
CMD ["node", "current/index.js"]
