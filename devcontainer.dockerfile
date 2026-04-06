FROM mcr.microsoft.com/devcontainers/base:ubuntu
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
    echo "allowed-users = *" >> /etc/nix/nix.custom.conf && \
    echo "trusted-users = root vscode actions-runner" >> /etc/nix/nix.custom.conf

RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install linux --init none --no-confirm


# COPY flake.lock ./flake.lock
# COPY flake.nix ./flake.nix
# COPY home.nix ./home.nix 
# RUN su -c "nix run .#activate" vscode
#source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>&1 
# & \
    # su -c "nix run .#activate" vscode
    
ENTRYPOINT ["/bin/bash", "-lc", "/nix/var/nix/profiles/default/bin/nix-daemon >/tmp/nix-daemon.log 2>&1 & exec \"$@\"", "--"]
CMD ["sleep", "infinity"]

# USER vscode
WORKDIR /workspaces