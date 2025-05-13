COMPOSE_FILE=src/docker-compose.yml

.PHONY: build up down restart logs clean prune

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

restart: down up

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

clean: down
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all

prune: down clean
	docker system prune -af --volumes

rebuild: clean up

debug: rebuild logs