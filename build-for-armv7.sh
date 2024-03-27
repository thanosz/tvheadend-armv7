#!/usr/bin/env bash

mkdir work
pushd work

git clone https://github.com/linuxserver/docker-baseimage-alpine.git
pushd docker-baseimage-alpine
sed -i 's/ENV ARCH=x86_64/ENV ARCH=armv7/g' Dockerfile
sed -i 's/ARG S6_OVERLAY_ARCH="x86_64"/ARG S6_OVERLAY_ARCH="armhf"/g' Dockerfile
docker build -t ghcr.io/linuxserver/baseimage-alpine .
popd
git clone https://github.com/linuxserver/docker-tvheadend.git
pushd docker-tvheadend
sed -i 's/baseimage-alpine:arm64v8-3.19/baseimage-alpine/g' Dockerfile.aarch64
docker build -t lscr.io/linuxserver/tvheadend -f Dockerfile.aarch64 .
popd
