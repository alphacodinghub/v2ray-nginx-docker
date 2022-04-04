# v2ray websocks tls + web all-in-one Docker

<a href="https://github.com/alphacodinghub/v2ray-docker/"><img src="https://img.shields.io/badge/Docker-v2ray-4BC51D.svg?style=flat"></a>
![](https://img.shields.io/badge/language-Web-orange.svg)
![](https://img.shields.io/badge/platform-Docker-lightgrey.svg)[![](https://img.shields.io/badge/Traefik-v2.x-blue.svg)](https://containo.us/traefik/)
![](https://img.shields.io/badge/license-MIT-000000.svg)

## [中文指引请点击此处](https://github.com/alphacodinghub/v2ray/blob/master/README_cn.md)

## V2Ray quick deployment using Traefik

- The Docker image is based on the latest official release and integrated with Nginx and a basic website.
- Deployment using Traefik, easy operation.
- Traefik automatically manages/renews ssl certificates.
- A basic static website is integrated with the image. It will redirect to baidu.com by default however you can replace it with your own real website.
- V2Ray parameters can be easily customized using the `.env` file. You don't need to change the `docker-compose.yml` file.
- Main parameters you can customize indlude domain name, UUID, v2ray listening port, and the camouflaged path.

## V2Ray server setup and configuration

### 1. VPS

- To buy a VPS and install Docker engine and git tool.
- To buy a domain, e.g. example.com.
- Choose an app name for your V2Ray server, e.g. `myapp`. Your camouflaged website url will then be `https://myapp.example.com`.
- Configure the DNS to point the domain `myapp.example.com` to the IP address of your VPS.

### 2. Clone this project to your VPS

```
- mkdir /app
- cd /app
- git clone https://github.com/alphacodinghub/v2ray-nginx-docker.git
- cd v2ray-nginx-docker
```

### 3. Configure VPS

To edit `.env` file and set necessary parameters. These three parameters must be set to your own values: APP_NAME (as chosen in Step 1), APP_DOMAIN, ACME_EMAIL (your email address for Let's Encrypt to apply for and renew ssl certificates). All other parameters can use the default values as provided. The final `.env` file should look like this (you should set your own values):

```
APP_NAME=myapp
APP_DOMAIN=example.com
ACME_EMAIL=myemail@example.com
LISTENING_PORT=3033
CLIENT_ID=2e5762cc-20d2-42b1-b0ad-cbe55dc5fa35
CLIENT_ALTERID=64
CLIENT_WSPATH=/allproducts
```

In the above settings, `CLIENT_WSPATH` is the so-called camouflaged path which should be set to the same value at the VPS server and user clients.

### 4. Website settings

By default, the caouflaged website will be redirected to baidu.com. You can copy your real website content to `./conf/html` folder to replace original files.

### 5. Start V2Ray server

After above settings, you can run the following command in folder `/app/v2ray-nginx-docker` to start the V2Ray server: `docker-compose up -d`. The `-d` option is to tell the programme to run in the background.

Run this command to check the running containers: `docker ps`.

To access to Traefik Dashboard：<https://traefik.example.com>
To visit the camouflaged website：<https://myapp.example.com>

## Client configuration

Download the Windows client V2RayN, run it and click the menu: server - add [VMess] server. Please set the values according to the below figure:
![v2ray配置](https://github.com/alphacodinghub/v2ray/blob/master/images/v2rayn.png)

> **References**

- [Official Project V Website](https://www.v2ray.com/)
- [新白话文教程-V2Ray 配置指南](https://guide.v2fly.org/)
- <a href="https://github.com/v2fly/docker">Official Dockerfile</a>
- <https://github.com/v2ray/ext>
