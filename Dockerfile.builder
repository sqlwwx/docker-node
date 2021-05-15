FROM sqlwwx/node-git:latest

RUN apk add --no-cache \
  make zip g++ python3

RUN pnpm i -g \
  standard-version oss-site-deployer jscpd jest \
  && find /usr/local/pnpm-global/ -name *.md | xargs rm -rf \
  && find /usr/local/pnpm-global/ -name docs -type d | xargs rm -rf \
  && find /usr/local/pnpm-global/ -name doc -type d | xargs rm -rf

RUN wget https://cdn.jsdelivr.net/gh/MestreLion/git-tools@master/git-restore-mtime \
  && chmod +x git-restore-mtime \
  && mv git-restore-mtime /usr/local/bin/
