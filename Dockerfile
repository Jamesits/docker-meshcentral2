FROM node:lts-slim

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
	&& apt-get install -y libcap2-bin gosu \
	&& rm -rf /var/lib/apt/lists/* \
	&& setcap cap_net_bind_service=+ep /usr/local/bin/node

WORKDIR /srv/meshcentral2

ARG MESHCENTRAL2_VERSION="0.5.81"
RUN npm install meshcentral@${MESHCENTRAL2_VERSION} \
	&& mkdir meshcentral-data meshcentral-files \
	&& chown -R node:node .

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME [ "/srv/meshcentral2/meshcentral-data", "/srv/meshcentral2/meshcentral-files" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "node", "./node_modules/meshcentral" ]

