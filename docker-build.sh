#!/bin/bash
set -ex

TAG="4.23"
docker build -t alphacodinghub/v2ray-nginx:$TAG .
docker build -t alphacodinghub/v2ray-nginx:latest .

# V2ray versions:
# 4.23.1    2020.05.01
