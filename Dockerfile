FROM n8nio/n8n:latest
USER root

RUN apk update && \
    apk add --no-cache \
    nmap \
    chromium \
    harfbuzz \
    freetype \
    ttf-freefont \
    nss \
    ca-certificates

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Zorg voor juiste permissions
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

USER node
WORKDIR /home/node

# Laat Railway de start command handelen
