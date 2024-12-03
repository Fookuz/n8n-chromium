FROM n8nio/n8n:latest

USER root

# Voeg benodigde packages toe
RUN apk update && \
    apk add --no-cache nmap && \
    apk add --no-cache udev chromium harfbuzz freetype ttf-freefont nss

# Stel environment variables in
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

USER node

# Overschrijf het standaard command om eerst de nodes te installeren
CMD cd /usr/local/lib/node_modules/n8n && npm install n8n-nodes-youtube-transcript@latest && n8n start
