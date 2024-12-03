FROM n8nio/n8n:latest

USER root

# Voeg benodigde packages toe
RUN apk update && \
    apk add --no-cache nmap && \
    apk add --no-cache udev chromium harfbuzz freetype ttf-freefont nss

# Stel environment variables in
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Installeer de community nodes direct met pnpm
RUN pnpm install -g n8n-nodes-youtube-transcript@latest

# Maak een wrapper script voor de startup
RUN echo '#!/bin/sh\npnpm install -g n8n-nodes-youtube-transcript@latest\nsu -c "n8n start" node' > /start.sh && \
    chmod +x /start.sh

# Gebruik het wrapper script als entrypoint
ENTRYPOINT ["/start.sh"]
