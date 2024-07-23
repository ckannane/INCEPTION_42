all : up

up : create_volume
	@docker-compose -f ./srcs/docker-compose.yml up -d

build : create_volume
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

down : 
	@docker-compose -f ./srcs/docker-compose.yml down -v --rmi all --remove-orphans
	

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

status : 
	@docker ps

create_volume :
	@mkdir -p /home/ckannane/data/wordpress
	@mkdir -p /home/ckannane/data/mariadb