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

RUN mkdir --parents /etc/nix/ && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.custom.conf && \
    echo "trusted-users = root vscode actions-runner" >> /etc/nix/nix.custom.conf

RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
sh -s -- install linux --init none --no-confirm

COPY .devcontainer/devcontainer.sh /usr/local/bin/devcontainer.sh
RUN chmod +x /usr/local/bin/devcontainer.sh

ENTRYPOINT ["/usr/local/bin/devcontainer.sh"]
CMD ["sleep", "infinity"]

USER ${USERNAME}
WORKDIR /workspaces