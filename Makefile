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
ifneq (,${ARGS})
	@docker compose up -d ${ARGS}
else
	@docker compose up -d
endif

down: ## Stop project
ifneq (,${ARGS})
	@docker compose stop ${ARGS}
	@docker compose rm ${ARGS}
else
	@docker compose down
endif

restart: ## Restart project
ifneq (,${ARGS})
	@docker compose restart ${ARGS}
else
	@make down
	@make up
endif

logs:  ## Container logs
ifneq (,${ARGS})
	@docker compose logs --tail 100 -f ${ARGS}
endif

sh:  ## Attach to container
ifneq (,${ARGS})
	@docker compose exec ${ARGS} sh
endif
