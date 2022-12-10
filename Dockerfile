FROM ubuntu:18.04

ENV UNITY_USERNAME=$UNITY_USERNAME
ENV UNITY_PASSWORD=$UNITY_PASSWORD
ENV UNITY_SERIAL=$UNITY_SERIAL

WORKDIR /app

# hadolint ignore=DL3008, DL3009
RUN apt-get update \
    && apt-get -y --no-install-recommends install git gnupg2 ca-certificates wget libxshmfence1 libdrm-dev libgbm1 libasound2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list' \
    && wget -qO - https://hub.unity3d.com/linux/keys/public | apt-key add -

RUN wget -nv https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb

# hadolint ignore=DL3008, DL3009
RUN apt-get update \
    && apt-get -y --no-install-recommends install -y dotnet-sdk-6.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends unityhub=3.3.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists
