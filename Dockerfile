FROM node:16-alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update --no-cache -v \
  && apk upgrade --no-cache -v \
  && apk add --no-cache \
     tzdata \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apk del tzdata

RUN npm config set registry https://registry.npmmirror.com

RUN npm i -g pnpm \
  && rm -rf /tmp/* && rm -rf $HOME/.npm/_cacache \
  && find /usr/local/lib/node_modules -name *.md | xargs rm -rf \
  && find /usr/local/lib/node_modules/ -name docs -type d | xargs rm -rf \
  && find /usr/local/lib/node_modules/ -name doc -type d | xargs rm -rf \
  && rm -rf /var/cache/apk/*

FROM scratch

COPY --from=builder / /

ENV NODE_ENV production

WORKDIR /app
