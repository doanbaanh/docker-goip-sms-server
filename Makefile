SHELL := /bin/bash

.DEFAULT_GOAL := help

ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

help: ## Show this help
	@printf "\033[33m%s:\033[0m\n" 'Available commands'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[32m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build project
	@docker compose build

up: ## Run project
	@docker compose up -d

down: ## Stop project
	@docker compose down

restart: ## Restart project
	@make down
	@make up

logs: ## Container logs
	@docker compose logs --tail 100 -f goip-sms-server

bash: ## Attach to container
	@docker compose exec goip-sms-server bash
