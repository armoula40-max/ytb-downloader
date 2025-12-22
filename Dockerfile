# n8n with yt-dlp (Debian-based)
FROM n8nio/n8n:latest

# Switch to root user
USER root

# Install Python3, pip, and yt-dlp (for Debian-based images)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install yt-dlp using pip
RUN pip3 install --break-system-packages -U yt-dlp

# Switch back to node user
USER node

# Verify installation
RUN yt-dlp --version
