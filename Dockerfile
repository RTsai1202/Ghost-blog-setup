# 1. 使用官方最新版 Ghost 6
FROM ghost:6-alpine

# 2. 【關鍵修正】明確告訴 Zeabur 我們的埠號是 2368
# 這能解決 502 Bad Gateway 問題
EXPOSE 2368
ENV PORT=2368

# 3. 切換成 Root 最高權限來安裝 S3 外掛
USER root
WORKDIR /var/lib/ghost

# 4. 安裝 S3 外掛 (這是官方映像檔沒有的)
RUN npm install ghost-storage-adapter-s3 && \
    mkdir -p content/adapters/storage/s3 && \
    cp -r node_modules/ghost-storage-adapter-s3/* content/adapters/storage/s3/ && \
    # 5. 【關鍵修正】把檔案權限還給 Ghost 的使用者 (node)
    # 這能解決 CrashLoopBackOff (崩潰重試) 問題
    chown -R node:node .

# 6. 切換回一般使用者啟動 (符合官方資安標準)
USER node

# 7. 啟動 Ghost
CMD ["node", "current/index.js"]
