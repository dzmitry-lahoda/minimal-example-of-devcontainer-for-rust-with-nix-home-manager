FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG USERNAME=vscode
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    xz-utils \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://install.determinate.systems/nix \
    | sh -s -- install --no-confirm

RUN echo '. "$HOME/.nix-profile/etc/profile.d/nix.sh"' >> /home/${USERNAME}/.bashrc && \
    chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.bashrc

USER ${USERNAME}
WORKDIR /workspaces