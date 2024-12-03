FROM n8io/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache nmap && \
    apk add --no-cache udev chromium harfbuzz freetype ttf-freefont nss

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Installeer community nodes
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install n8n-nodes-youtube-transcript@latest

USER node
