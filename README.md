# v2ray-arukas-all-in-one

![](https://img.shields.io/badge/language-Web-orange.svg)
![](https://img.shields.io/badge/platform-Docker-lightgrey.svg)
A v2ray docker image work with nginx for Arukas/IBM/okteto

- v2ray work with websocket
- v2ray request proxy_pass by nginx
- custom v2ray settings
- add environment variables to edit optional setting
  - CLIENT_ID (default ad806487-2d26-4636-98b6-ab85cc8521f7)
  - CLIENT_ALTERID (default 64)
  - CLIENT_WSPATH (default /ws)
  - VER (default 4.19.1)
- don't need custom domain and ssl certificate
- only cost 1 pods

**USE: deploy this image and add default secure route with port 8080 in arukas**

- path to v2ray: https://your.domain/fuckgfw_letscrossgfw
- path to websites: /usr/share/nginx/html/

实例教程参考 ：

- <a href="https://doubibackup.com/v2ray-ws-tls-nginx.html" target="_blank">V2Ray+WebSocket+TLS+Nginx 配置与使用教程</a>
- https://toutyrater.github.io/advanced/wss_and_web.html
- https://bawodu.com/openshift-v2ray/
- <a href="https://github.com/v2fly/docker">Official Dockerfile</a>
- https://github.com/v2ray/ext
- https://toutyrater.github.io/app/docker-deploy-v2ray.html
- <a href="https://vimcaw.github.io/blog/2018/03/12/Shadowsocks(R)%E8%AE%BE%E7%BD%AE%EF%BC%9A%E7%B3%BB%E7%BB%9F%E4%BB%A3%E7%90%86%E6%A8%A1%E5%BC%8F%E3%80%81PAC%E3%80%81%E4%BB%A3%E7%90%86%E8%A7%84%E5%88%99/">SSR proxy settings - a great explaination</a>
