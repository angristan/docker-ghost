# https://docs.ghost.org/supported-node-versions/
# https://github.com/nodejs/LTS
FROM node:8-alpine

# grab su-exec for easy step-down from root
RUN apk add --no-cache 'su-exec>=0.2'

RUN apk add --no-cache \
# add "bash" for "[["
		bash

ENV NODE_ENV production

ENV GHOST_CLI_VERSION 1.9.6
RUN npm config set unsafe-perm true \
	&& npm install -g "ghost-cli@$GHOST_CLI_VERSION"

ENV GHOST_INSTALL /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost/content

ENV GHOST_VERSION 2.2.1

RUN set -ex; \
	mkdir -p "$GHOST_INSTALL"; \
	chown node:node "$GHOST_INSTALL"; \
	\
	su-exec node ghost install "$GHOST_VERSION" --db sqlite3 --no-prompt --no-stack --no-setup --dir "$GHOST_INSTALL"; \
	\
# Tell Ghost to listen on all ips and not prompt for additional configuration
	cd "$GHOST_INSTALL"; \
	su-exec node ghost config --ip 0.0.0.0 --port 2368 --no-prompt --db sqlite3 --url http://localhost:2368 --dbpath "$GHOST_CONTENT/data/ghost.db"; \
	su-exec node ghost config paths.contentPath "$GHOST_CONTENT"; \
	\
# make a config.json symlink for NODE_ENV=development (and sanity check that it's correct)
	su-exec node ln -s config.production.json "$GHOST_INSTALL/config.development.json"; \
	readlink -f "$GHOST_INSTALL/config.development.json"; \
	\
# need to save initial content for pre-seeding empty volumes
	mv "$GHOST_CONTENT" "$GHOST_INSTALL/content.orig"; \
	mkdir -p "$GHOST_CONTENT"; \
	chown node:node "$GHOST_CONTENT"

# TODO multiarch sqlite3 (once either "node:6-alpine" has multiarch or we switch to a base that does)

WORKDIR $GHOST_INSTALL
VOLUME $GHOST_CONTENT

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 2368
CMD ["node", "current/index.js"]
