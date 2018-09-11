# Ghost

![https://hub.docker.com/r/angristan/ghost/](https://img.shields.io/microbadger/image-size/angristan/ghost.svg?maxAge=3600&style=flat-square) ![https://hub.docker.com/r/angristan/ghost/](https://img.shields.io/microbadger/layers/angristan/ghost.svg?maxAge=3600&style=flat-square) ![https://hub.docker.com/r/angristan/ghost/](https://img.shields.io/docker/pulls/angristan/ghost.svg?maxAge=3600&style=flat-square) ![https://hub.docker.com/r/angristan/ghost/](https://img.shields.io/docker/stars/angristan/ghost.svg?maxAge=3600&style=flat-square)

![Ghost Logo](https://ghost.org/logo.svg)

[Ghost](https://ghost.org/) is a fully open source, adaptable platform for building and running a modern online publication.

This image is automatically built by [GitLab CI](https://gitlab.com/angristan/docker-ghost/pipelines) and pushed to the [Docker Hub](https://hub.docker.com/r/angristan/ghost/).

Besides manual updates, the images are automatically rebuilt every week to make sure all softwares in the images are up-to-date.

## Features

- Based on `node:8-alpine`
- Running the latest stable version of [TryGhost/Ghost](https://github.com/TryGhost/Ghost), installed by [TryGhost/Ghost-CLI](https://github.com/TryGhost/Ghost-CLI).
- It's mostly based on the official [Ghost 2 Alpine image](https://github.com/docker-library/ghost/tree/master/2/alpine). There is a often a multiple-days delay after each Ghost update before the Docker image is updated. So I decided to build and host mine.

### Build-time variables

- **`GHOST_VERSION`**: Ghost version (`2.1.2`)
- **`GHOST_CLI_VERSION`**: Ghost-CLI version (`1.9.3`)

### Volumes

- **`/var/lib/ghost/content`**

## Usage

See my blog post: [Migrating Ghost to Docker](https://angristan.xyz/migrating-ghost-to-docker/).

It has docker-compose and Nginx examples.
