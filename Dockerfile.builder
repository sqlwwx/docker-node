FROM sqlwwx/node-git:latest

ADD git-restore-mtime /usr/local/bin/

RUN apk add --no-cache \
  make zip g++ 

RUN pnpm i -g \
  standard-version oss-site-deployer jscpd jest \
  && find /usr/local/share/pnpm -name *.md | xargs rm -rf \
  && find /usr/local/share/pnpm -type d -empty -delete \
  && find /usr/local/lib/node_modules -name *.md | xargs rm -rf \
  && find /usr/local/lib/node_modules -type d -empty -delete
