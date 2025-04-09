FROM docker.io/library/node:22-bookworm-slim

# Install mongodb tools for online backup
COPY --chown=0:0 rootfs_overrides/. /
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update -y \
	&& apt-get install -y libcap2-bin mongodb-org-tools \
	&& rm -rf /var/lib/apt/lists/*

RUN setcap 'cap_net_bind_service=+ep' "$(command -v node)"

WORKDIR /srv/meshcentral2
ENV NODE_ENV="production"
COPY .npmrc package.json pnpm-lock.yaml .
RUN corepack enable \
	&& pnpm install --frozen-lockfile \
	# https://github.com/Ylianst/MeshCentral/blob/0d346b1d62f600438a0df2f63ab6a3cca66fe7cd/docker/Dockerfile#L20
	# I don't know WTF is this. It looks hacky to me.
	&& (cd node_modules/meshcentral/translate && node translate.js extractall && node translate.js minifyall && node translate.js translateall) \
	&& mkdir meshcentral-data meshcentral-files \
	&& chown -R node:node .

USER node:node

EXPOSE 80 443 4433
VOLUME [ "/srv/meshcentral2/meshcentral-data", "/srv/meshcentral2/meshcentral-files", "/srv/meshcentral2/backup" ]
CMD [ "node", "./node_modules/meshcentral" ]
