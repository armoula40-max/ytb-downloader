FROM n8nio/n8n:latest

USER root

# التحقق التلقائي من نوع النظام وتثبيت المتطلبات
RUN if command -v apk >/dev/null 2>&1; then \
        apk add --no-cache python3 py3-pip ffmpeg curl build-base python3-dev; \
    else \
        apt-get update && \
        apt-get install -y --no-install-recommends python3 python3-pip python3-venv ffmpeg curl && \
        rm -rf /var/lib/apt/lists/*; \
    fi

# إنشاء بيئة Python افتراضية (يحل مشاكل externally-managed-environment)
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -U pip && \
    /opt/venv/bin/pip install --no-cache-dir -U yt-dlp

# إضافة yt-dlp إلى PATH
ENV PATH="/opt/venv/bin:$PATH"

USER node

# التحقق من التثبيت
RUN yt-dlp --version
