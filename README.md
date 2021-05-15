# docker-node
![Docker](https://github.com/sqlwwx/docker-node/workflows/Docker/badge.svg)

# images
```
sqlwwx/node
sqlwwx/node-git
sqlwwx/node-builder
```

# clean
```
find /var/ -size +10
du --max-depth=1 .
find /usr/lib/node_modules/ -name *.md | xargs rm
rm -rf /var/cache/apk/*
```
