FROM ghost:6-alpine

# 切換成 root 來安裝外掛，確保有權限
USER root

# 安裝 S3 外掛並修正檔案權限 (這是關鍵！)
RUN cd /var/lib/ghost && \
    npm install ghost-storage-adapter-s3 && \
    mkdir -p content/adapters/storage/s3 && \
    cp -r node_modules/ghost-storage-adapter-s3/* content/adapters/storage/s3/ && \
    # 把這些檔案的主人改成 node (Ghost 的使用者)
    chown -R node:node content/adapters

# 切換回 node 使用者啟動，比較安全
USER node

CMD ["node", "current/index.js"]
