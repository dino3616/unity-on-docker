FROM ubuntu:20.04

ENV UNITY_USERNAME=$UNITY_USERNAME
ENV UNITY_PASSWORD=$UNITY_PASSWORD

WORKDIR /app

# hadolint ignore=DL3008, DL3009
RUN apt-get update \
    && apt-get -y --no-install-recommends install gnupg2 ca-certificates wget libxshmfence1 libdrm-dev libgbm1 libasound2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list' \
    && wget -qO - https://hub.unity3d.com/linux/keys/public | apt-key add -

RUN apt-get update \
    && apt-get install -y --no-install-recommends unityhub=3.3.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

RUN unityhub --headless install --version 2021.3.15f1 --module standardassets language-ja
