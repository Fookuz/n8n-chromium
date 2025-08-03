FROM n8nio/n8n:latest
USER root

# Installeer systeem-dependencies voor Chromium etc.
RUN apk update && \
    apk add --no-cache \
    nmap \
    chromium \
    harfbuzz \
    freetype \
    ttf-freefont \
    nss \
    ca-certificates

# Configureer environment voor de ingebouwde Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Maak de .n8n directory en zet de juiste eigenaar (ook al draaien we als root)
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# CRUCIAAL: Blijf als root user voor compatibiliteit met Railway's start commando's
USER root
