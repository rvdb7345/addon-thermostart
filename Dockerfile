ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.6.2
FROM ${BUILD_FROM}

ENV \
  PIP_BREAK_SYSTEM_PACKAGES=1 \
  THERMOSTART_VERSION="main" \
  THERMOSTART_COMMIT="b3f20e3b614cc30af2ddd37164628ac6b67207a6"

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Sets working directory
WORKDIR /opt

# Setup base
ARG BUILD_ARCH=amd64
RUN \
  apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    python3-dev \
    python3-pip \
    python3 \
    nginx \
  \
  && git clone --branch "${THERMOSTART_VERSION}" --depth=1 \
    https://github.com/rvdb7345/thermostart.git /opt \
  \
  && pip install \
    --no-cache-dir \
    --prefer-binary \
    --extra-index-url "https://www.piwheels.org/simple" \
    -r /opt/services/web/requirements.txt \
  \
  && find /usr/local \
    \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    -exec rm -rf '{}' + \
  \
  && apt-get purge -y --auto-remove \
    build-essential \
    git \
    python3-dev \
    python3-pip \
  \
  && rm -fr \
    /opt/{.git,.github,init-scripts} \
    /tmp/* \
    /var/{cache,log}/* \
    /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

WORKDIR /opt/services/web

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
