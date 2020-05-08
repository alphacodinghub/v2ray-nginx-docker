# v2ray websocks tls + web all-in-one Docker

<a href="https://github.com/alphacodinghub/v2ray-docker/"><img src="https://img.shields.io/badge/Docker-v2ray-4BC51D.svg?style=flat"></a>
![](https://img.shields.io/badge/language-Web-orange.svg)
![](https://img.shields.io/badge/platform-Docker-lightgrey.svg)[![](https://img.shields.io/badge/Traefik-v2.x-blue.svg)](https://containo.us/traefik/)
![](https://img.shields.io/badge/license-MIT-000000.svg)

## Traefik 快速部署 V2RAY

- Docker 镜像基于 v2ray 官方最新版本，并集成 Nginx 服务器和一个简易网站
- 使用 Traefik 反向代理进行部署，操作简单，系统稳定
- Traefik 自动管理 Let's Encrypt，自动申请 ssl 证书，证书过期前自动更新
- 集成了一个简易伪装网站，缺省跳转至百度；也可以作为正式网站使用，只要将网站内容放到指定目录即可
- 可以定制 v2ray 参数，只要在.env 中按照模板设置相应参数即可，无需修改 docker-compose.yml
- 可以定制的 v2ray 参数包括：域名、UUID、监听端口、伪装路径等

## 服务器安装和配置步骤

### 1. 准备虚拟主机

- 申请虚拟主机，安装最新的 Docker 引擎和 git 工具。
- 申请一个域名，例如 `example.com`。
- 选择一个名字作为`v2ray`应用的名称，例如`myapp`，那么`https://myapp.example.com`就是那个伪装的网站入口。
- 配置域名服务器，将`myapp.example.com`指向上一步申请的虚拟主机的 IP 地址。

### 2. 将本项目克隆到虚拟机相应目录，例如 /app/v2ray-nginx-docker

```script class:"lineNo"
- mkdir /app
- cd /app
- git clone https://github.com/alphacodinghub/v2ray-nginx-docker.git
- cd v2ray-nginx-docker
```

### 3. 配置参数(服务器)

紧接着修改`.env`文件，设定相关参数，以下三个参数必须设置：`APP_NAME`(第一步中选定的 v2ray 应用名称)，`APP_DOMAIN`(第一步中申请的域名)，`ACME_EMAIL`(你的 Email 地址，Let's Engcrypt 申请和更新证书的时候需要)，其它参数都可以使用缺省参数，甚至可以从`.env`文件中去掉，`docker-compose.yml`中设置了缺省参数，可以打开查看。设置好的`.env`文件看起来这样：

```env
APP_NAME=myapp
APP_DOMAIN=example.com
ACME_EMAIL=myemail@example.com
LISTENING_PORT=3033
CLIENT_ID=2e5762cc-20d2-42b1-b0ad-cbe55dc5fa35
CLIENT_ALTERID=64
CLIENT_WSPATH=/allproducts
```

#### 上述配置中

```
- LISTENING_PORT: 是v2ray服务的监听端口
- CLIENT_ID: 是UUID，必须按规定的格式设置，v2ray用UUID加密传输，可以使用在线工具(https://www.uuidgenerator.net/)生成UUID
- CLIENT_ALTERID: 是`alterid`，为了进一步防止被探测，一个用户可以在主 UUID 的基础上，再额外生成多个 ID。这里只需要指定额UUUU ID 的数量，推荐值为 4。不指定的话，默认值是 0。最大值 65535。客户端也有对应的设置，客户端的这个值不能超过服务器端所指定的值
- CLIENT_WSPATH: 设置的伪装路径，客户端的配置要和服务器端的一致
- 如上配置的伪装网站为`https://myapp.example.com`，完整的v2ray伪装路径是`myapp.example.com/allproducts`
```

### 4. 伪装网站的配置

缺省情况下访问伪装网站`https://myapp.example.com`时会跳转至百度。可以将所需伪装成的网站拷贝至目录`./conf/html`下替换原有文件即可。如果直接访问伪装路径`https://myapp.example.com/allproducts`则会返回`Bad Request`。

### 5. 启动服务器

按上述步骤配置以后，在目录`/app/v2ray-nginx-docker`下运行下述命令即可： `docker-compose up -d`，其中参数`-d`表示在后台运行。查看启动的容器用这个命令：
`docker ps`。至此，服务器端的部署已经完成。

访问 Traefik Dashboard：https://traefik.example.com
访问伪装网站：https://myapp.example.com

## 客户端配置

下载 Windows 客户端 V2RayN。
打开软件，依次点击：服务器 - 添加[VMess]服务器，按下图配置参数：

![v2ray配置](https://github.com/alphacodinghub/v2ray/blob/master/images/v2rayn.png)

> **参考资料：**

- [官方 Project V 网站](https://www.v2ray.com/)
- [新白话文教程-V2Ray 配置指南](https://guide.v2fly.org/)
- <a href="https://github.com/v2fly/docker">Official Dockerfile</a>
- https://github.com/v2ray/ext
