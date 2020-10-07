FROM node:12.18.4-alpine3.9

WORKDIR /react

COPY app ./app
COPY dist ./dist

COPY webpack.config.js .
COPY package.json .
COPY package-lock.json .

ENV HOME=/home/user
RUN apk add --update curl; mkdir -p ${HOME}; mkdir -p ${HOME}/.config && chgrp 0 ${HOME}; chmod g+rwX ${HOME} && chmod -R 777 ${HOME} && npm install; npm run build; \
    chown -R $USER:$(id -gn $USER) ~/.config 

ENTRYPOINT [ "npm", "run", "start" ]
