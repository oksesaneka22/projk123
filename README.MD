docker network create app-network

docker volume create mysql_data

docker run -d --name mysql --network app-network -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=todo_db -p 3306:3306 -v mysql_data:/var/lib/mysql oksesaneka22/mysql:latest

docker run -d --name backend --network app-network -p 3000:3000 --link mysql oksesaneka22/backend:latest

docker run -d --name frontend --network app-network -p 80:80 oksesaneka22/frontend:latest

`docker-compose up --build -d`
