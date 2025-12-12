FROM ghost:6-alpine

RUN apk add --no-cache git unzip

COPY RTsai-theme.zip /tmp/
RUN unzip /tmp/RTsai-theme.zip -d /tmp/ && \
    mkdir -p /var/lib/ghost/content/themes && \
    mv "/tmp/RTsai theme" /var/lib/ghost/content/themes/RTsai-theme && \
    rm /tmp/RTsai-theme.zip

RUN cp -r /var/lib/ghost/current/content/themes/casper /var/lib/ghost/content/themes/

RUN mkdir -p /var/lib/ghost/content/adapters/storage && \
    cd /var/lib/ghost/content/adapters/storage && \
    git clone https://github.com/cinntiq/ghost-storage-cloudflare-r2.git cloudflare-r2 && \
    cd cloudflare-r2 && \
    npm install --omit=dev

RUN chown -R node:node /var/lib/ghost/content
