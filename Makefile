.DEFAULT_GOAL := help

TAG = latest
IMAGE_NAME = app
PROYECT_NAME = app
APP_SERVICE = app
CONTAINER_OWNER = cyacarini
DB_SERVICE = app_db
DB_DEV = myapp_development


######## Manage containers status (default target = all)
status: ## Show containers status, use me with: make status target=api
	docker-compose ps ${target}

stop: ## Stops the docker containers, use me with: make stop target=api
	docker-compose stop ${target}

down: ## Stops and removes the docker containers, use me with: make down target=api
	docker-compose down ${target}

delete: ## Delete the docker containers, use me with: make delete target=api
	docker-compose rm -fv ${target}

build: ## Build the docker containers, use me with: make build target=api
	docker-compose build ${target}

up: ## Up the docker containers, use me with: make up target=api
	docker-compose up -d ${target}

logs: ## Logss the docker containers, use me with: make logs target=api
	docker-compose logs -f ${target}

restart: ## Restart the docker containers, use me with: make restart target=api
	docker-compose restart ${target}

ssh: ## SSH connect to container, se me with: make ssh target=api
		docker-compose -p $(PROYECT_NAME) run --rm ${target} sh -c "bash"

######## Manage containers execution
rebuild: # Init the docker containers, use me with: make init
	make stop && make delete
	rm -r ./code
	mkdir ./code
	cp ./configs/Gemfile ./code/Gemfile
	cp ./configs/Gemfile.lock ./code/Gemfile.lock
	docker-compose run ${APP_SERVICE} rails new . --force --database=postgresql
	docker-compose build
	docker-compose up -d
	cp ./configs/database.yml ./code/config/database.yml
	docker-compose run ${APP_SERVICE} rake db:create
	docker-compose run --rm ${APP_SERVICE} rails g scaffold note title body:text
	docker-compose run --rm ${APP_SERVICE} rake db:migrate


######## Manage containers execution
exec: ## Execute command in the docker container, use me with: make exec target=api cmd=ls
	docker exec ${target} ${cmd}

######## Build image from container
commit: ## Commit the docker containers, use me with: make commit target=api revision=1.0
	docker commit ${options} ${target} ${revision}

push: ## Push the docker containers, use me with: make push revision=1.0
	docker push ${revision}

######## Dump DB
dump.db: ## Dump database, use me with: make dump.db
	docker exec ${DB_SERVICE} pg_dump -U postgres --data-only --column-inserts ${DB_DEV} > ${DB_DEV}.dump.db.sql

###### Help
help:
	@echo  'Development commands for project ${PROYECT_NAME}'
	@echo
	@echo 'Usage: make COMMAND [target=some-targets] [cms=some-commads] [revision=some-revision]'
	@echo
	@echo 'Targets:'
	@echo
	@echo '  app            Rails App'
	@echo '  db         		Postgres DB'
	@echo
	@echo '  default target=all'
	@echo
	@echo 'Commands:'
	@echo
	@grep -E '^[a-zA-Z_-]+.+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'
	@echo
