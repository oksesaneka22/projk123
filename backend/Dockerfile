FROM node:16

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

COPY . .

RUN npm ci

RUN npm install cors

EXPOSE 3000

CMD ["node", "server.js"]
