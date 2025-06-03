# Container services for MADS

This compose file starts container services for mongodb, mads-broker and mads-logger.

## Starting the services

```sh
docker compose up
```

As a daemon:

```sh
docker compose up -d
``` 


## Building the container

The container is automatically built on the first launch, but it can be explicitly built with:

```sh
docker buildx build --platform=linux/amd64,linux/arm64 -t mads .       
```

## Specify MADS version

The MADS version to be used can be specified by editing the `.env` file, by changing the value for `MADS_VERSION`. Version string format is `MAJOR.MINOR.RELEASE`, with **no leading `v`** (e.g. `1.2.6`).