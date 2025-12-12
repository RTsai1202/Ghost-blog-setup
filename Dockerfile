FROM ghost:6-alpine

# 安裝 Cloudflare R2 Storage Adapter（從 GitHub 安裝）
RUN cd /tmp && \
    wget https://github.com/egeldenhuys/ghost-cloudflare-r2/archive/refs/heads/main.zip && \
    unzip main.zip && \
    mkdir -p /var/lib/ghost/content/adapters/storage/cloudflare-r2 && \
    cp -r ghost-cloudflare-r2-main/* /var/lib/ghost/content/adapters/storage/cloudflare-r2/ && \
    cd /var/lib/ghost/content/adapters/storage/cloudflare-r2 && \
    npm install && \
    rm -rf /tmp/*
