FROM n8nio/n8n:latest

USER root

# Voeg benodigde packages toe
RUN apk update && \
    apk add --no-cache nmap && \
    apk add --no-cache udev chromium harfbuzz freetype ttf-freefont nss

# Stel environment variables in
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Maak een script aan dat de nodes installeert bij opstarten
COPY <<EOF /docker-entrypoint.d/install-nodes.sh
#!/bin/sh
cd /usr/local/lib/node_modules/n8n
npm install n8n-nodes-youtube-transcript@latest
EOF

RUN chmod +x /docker-entrypoint.d/install-nodes.sh

USER node
