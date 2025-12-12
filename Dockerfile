FROM ghost:6-alpine

# 強制設定環境變數，防止變數沒吃到
ENV PORT=2368
ENV NODE_ENV=production

# 告訴 Zeabur 我們的門牌號碼
EXPOSE 2368

# ⚠️ 關鍵改變：全程使用 Root 最高權限
# 這雖然不是資安滿分，但能解決所有的 502 和權限崩潰問題
USER root
WORKDIR /var/lib/ghost

# 安裝外掛
RUN npm install ghost-storage-adapter-s3 && \
    mkdir -p content/adapters/storage/s3 && \
    cp -r node_modules/ghost-storage-adapter-s3/* content/adapters/storage/s3/

# 直接啟動，不切換使用者
CMD ["node", "current/index.js"]
