FROM node:20-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw
RUN curl -fsSL https://openclaw.ai/install.sh | bash

# Set working directory
WORKDIR /app

# Copy project files
COPY package*.json ./
RUN npm install

COPY . .

# Create OpenClaw config directory
RUN mkdir -p /root/.openclaw

# Expose gateway port
EXPOSE 18789

# Start script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
