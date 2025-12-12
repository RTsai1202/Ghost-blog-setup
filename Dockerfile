FROM ghost:6-alpine

# 1. 切換成最高權限 root 來安裝東西
USER root

# 2. 設定工作目錄
WORKDIR /var/lib/ghost

# 3. 安裝 S3 外掛
RUN npm install ghost-storage-adapter-s3

# 4. 建立目錄並移動外掛檔案
RUN mkdir -p content/adapters/storage/s3 && \
    cp -r node_modules/ghost-storage-adapter-s3/* content/adapters/storage/s3/

# 5. 🔥 最關鍵的一步：把所有檔案的擁有者強行改成 node (Ghost 的使用者)
# 這樣 Ghost 啟動時才不會因為沒有權限讀取外掛而崩潰
RUN chown -R node:node /var/lib/ghost

# 6. 切換回 node 使用者來啟動 (符合 Ghost 安全規範)
USER node

# 7. 啟動命令
CMD ["node", "current/index.js"]
