FROM ubuntu:latest as builder

RUN apt-get update
RUN apt-get install curl -y
RUN curl -L -o /tmp/go.sh https://install.direct/go.sh
RUN chmod +x /tmp/go.sh
RUN /tmp/go.sh


FROM alpine:3.11

LABEL Maintainer="George Zhou<alphacodinghub@outlook.com >" \
  Description="V2Ray all-in-one image with ws-tls option based on Alpine Linux." \
  Language="HTML" \
  OS="Alpine Linux" \
  Service="V2Ray" \
  Content="V2RAY"

ENV CLIENT_ID "2e5762cc-20d2-42b1-b0ad-cbe55dc5fa35"
ENV CLIENT_ALTERID 64
ENV CLIENT_WSPATH "/allproducts"
#ENV VER=4.23.1
ENV PATH /usr/bin/v2ray:$PATH

# ensure www-data user exists
RUN set -eux; \
  addgroup -g 82 -S www-data; \
  adduser -u 82 -D -S -G www-data www-data; 
# 82 is the standard uid/gid for "www-data" in Alpine

#install v2ray
COPY --from=builder /usr/bin/v2ray/v2ray /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/v2ctl /usr/bin/v2ray/
COPY docker-conf/config.json /etc/v2ray/config.json

RUN set -ex && \
  apk update && \
  apk --no-cache add ca-certificates \
  nginx \
  supervisor && \
  rm -rf /var/cache/apk/* && \
  mkdir /var/log/v2ray/ &&\
  chmod +x /usr/bin/v2ray/v2ctl && \
  chmod +x /usr/bin/v2ray/v2ray

RUN rm -rf /etc/localtime
COPY docker-conf/localtime /etc/

# configure Nginx
COPY docker-conf/nginx.conf /etc/nginx/
COPY docker-conf/default.conf /etc/nginx/conf.d/
# configure supervisord
COPY docker-conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#  web content volume
VOLUME /var/www/html
WORKDIR /var/www/html
COPY docker-conf/html/* /var/www/html/
RUN chown -R www-data.www-data /var/www

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
