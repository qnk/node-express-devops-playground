FROM node

COPY . package.json

RUN apt-get update && \
    apt-get install -y nodejs  && \
    npm i -g express-generator && \
    mkdir /opt/app

WORKDIR /opt/app
RUN express -f

WORKDIR /opt/app/express
RUN npm i

CMD [ "npm", "start" ]
