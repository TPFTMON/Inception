NAME = inception
COMPOSE = srcs/docker-compose.yml
DATA_DIR = /home/abaryshe/data

all: build

build:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	docker compose -f $(COMPOSE) up -d --build

down:
	docker compose -f $(COMPOSE) down

clean: down
	docker compose -f $(COMPOSE) down --rmi all -v

fclean: clean
	@sudo rm -rf $(DATA_DIR)/mariadb/*
	@sudo rm -rf $(DATA_DIR)/wordpress/*
	docker system prune -af --volumes

re: fclean all

.PHONY: all build down clean fclean re