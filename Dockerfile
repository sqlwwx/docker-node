FROM node:22-alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update -v && apk upgrade -v \
  && apk add --no-cache tzdata gcompat python3 \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apk del tzdata \
  && rm -rf /var/cache/apk/*

RUN npm config set registry https://registry.npmmirror.com

RUN npm install -g npm \
  && npm i pnpm --location=global \
  && rm -rf /tmp/* && rm -rf $HOME/.npm/_cacache && rm -rf $HOME/.npm/_logs \
  && find /usr/local/lib/node_modules -name *.md | xargs rm -rf \
  && find /usr/local/lib/node_modules -type d -empty -delete

FROM scratch

COPY --from=builder / /

RUN mkdir -p /usr/local/share/pnpm
ENV PNPM_HOME /usr/local/share/pnpm
ENV PATH ${PNPM_HOME}:${PATH}
ENV NODE_ENV production

WORKDIR /app
