FROM node:lts-slim

COPY etc /etc/
COPY usr /usr/

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update -y \
	&& apt-get install -y libcap2-bin gosu mongodb-org-tools \
	&& rm -rf /var/lib/apt/lists/* \
	&& setcap cap_net_bind_service=+ep /usr/local/bin/node

WORKDIR /srv/meshcentral2

ARG NODE_ENV="production"
ARG MESHCENTRAL2_VERSION="0.7.48"
RUN npm install --save meshcentral@${MESHCENTRAL2_VERSION} \
	&& npm install --no-optional --save archiver mongodb saslprep otplib@10.2.3 image-size node-rdpjs-2 archiver-zip-encrypted passport passport-azure-oauth2 jwt-simple nodemailer \
	&& mkdir meshcentral-data meshcentral-files \
	&& chown -R node:node .

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80 443 4433
VOLUME [ "/srv/meshcentral2/meshcentral-data", "/srv/meshcentral2/meshcentral-files" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "node", "./node_modules/meshcentral" ]

