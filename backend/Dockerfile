FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install cors

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
