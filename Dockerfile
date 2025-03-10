FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

# VOLUME [ "/app/node_modules" ]

# For nodemon
CMD [ "npm", "start" ]
# CMD [ "node", "server.js" ]