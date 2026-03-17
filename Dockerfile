FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# System packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    pipx \
    && rm -rf /var/lib/apt/lists/*

# Make sure pipx is on PATH
ENV PIPX_BIN_DIR=/usr/local/bin
ENV PIPX_HOME=/opt/pipx
ENV PATH="${PIPX_BIN_DIR}:${PATH}"

# Optional: pre-install claude-code inside the container image
# Comment this line out if you prefer to install it manually in the running container
RUN pipx install claude-code || true

# Workspace directory (will be overridden by devcontainer mount)
WORKDIR /workspaces/project

# Default shell
CMD [ "bash" ]

