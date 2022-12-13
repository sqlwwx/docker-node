FROM sqlwwx/node-git:latest

RUN apk add --no-cache \
  make zip g++ python3

RUN pnpm i -g \
  standard-version oss-site-deployer jscpd jest \
  && find /usr/local/share/pnpm -name *.md | xargs rm -rf \
  && find /usr/local/share/pnpm -type d -empty -delete \
  && find /usr/local/lib/node_modules -name *.md | xargs rm -rf \
  && find /usr/local/lib/node_modules -type d -empty -delete

RUN wget https://cdn.jsdelivr.net/gh/MestreLion/git-tools@master/git-restore-mtime \
  && chmod +x git-restore-mtime \
  && mv git-restore-mtime /usr/local/bin/
