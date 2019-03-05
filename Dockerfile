FROM node:8.15.1-jessie as backend
WORKDIR /app/

COPY package.json package.lock /app/
RUN npm init && install


FROM nginx:8.15.1-jessie
WORKDIR /app/

COPY --from=0 /app/ /opt/