FROM ghcr.io/ublue-os/bluefin-cli:latest

LABEL   com.github.containers.toolbox="true" \
        usage="This image is meant to be used with the Toolbox or Distrobox commands" \
        summary="A new cloud-native terminal experience powered by Wolfi and Homebrew" \
        maintainer="27022259+auricom@users.noreply.github.com"

COPY ./extra-packages /extra-packages

# Remove default fish bling script, Install extra packages, nix-portable and devbox
RUN  \
    rm /usr/share/fish/vendor_conf.d/bling.fish /usr/share/fish/vendor_conf.d/brew.fish && \
    grep -v '^#' /extra-packages | xargs apk add && \
    rm /extra-packages && \
    wget --quiet --output-document /usr/bin/nix-portable \
        https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m) && \
    chmod +x /usr/bin/nix-portable && \
    ln -s /usr/bin/nix-portable /usr/bin/nix && \
    ln -s /usr/bin/nix-portable /usr/bin/nix-shell && \
    curl -fsSL https://get.jetify.com/devbox | bash -s -- --force && \
    mv /usr/local/bin/devbox /usr/bin/devbox && \
    chmod +r /usr/bin/devbox

ENV NP_GIT=/usr/bin/git
