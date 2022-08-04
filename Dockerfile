FROM node:18.6 AS appbuild
WORKDIR /usr/src/app
RUN npm install npm -g
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# Build Stage 2
# This build takes the production build from staging build
#
FROM node:18.6-alpine
WORKDIR /usr/src/app
RUN npm install npm -g
COPY package*.json ./
RUN npm install
COPY --from=appbuild /usr/src/app/dist ./dist
EXPOSE 8000
ENTRYPOINT [ "bash", "entrypoint.sh" ]
