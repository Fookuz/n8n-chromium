FROM n8nio/n8n:latest

USER root

# Voeg benodigde packages toe
RUN apk update && \
    apk add --no-cache nmap && \
    apk add --no-cache udev chromium harfbuzz freetype ttf-freefont nss

# Stel environment variables in
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Maak de nodes directory aan en zet permissies
RUN mkdir -p /home/node/.n8n/nodes && \
    chown -R node:node /home/node/.n8n && \
    chown -R node:node /usr/local/lib/node_modules/n8n

# Installeer oauth-1.0a als root
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install oauth-1.0a

USER node

# Installeer andere nodes
RUN cd /home/node/.n8n/nodes && \
    npm init -y && \
    npm install n8n-nodes-youtube-transcript@latest && \
    npm install n8n-nodes-cloudconvert@latest
