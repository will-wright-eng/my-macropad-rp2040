#* Variables
SHELL := /usr/bin/env bash
REPO_ROOT := $(shell git rev-parse --show-toplevel)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
SCRIPTS_DIR := ${REPO_ROOT}/scripts

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

#* Setup
.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))
.DEFAULT_GOAL := help

help: ## list make commands
	@echo ${MAKEFILE_LIST}
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


deploy: ## deploy to macropad
	@echo "Deploying to MacroPad..."
	bash ${SCRIPTS_DIR}/deploy.sh

clean: ## clean macropad
	@echo "Cleaning CIRCUITPY drive..."
	bash ${SCRIPTS_DIR}/clean.sh

backup: ## create backup
	@echo "Creating backup..."
	bash ${SCRIPTS_DIR}/backup.sh

libs: ## install library dependencies
	@echo "Installing CircuitPython libraries..."
	bash ${SCRIPTS_DIR}/lib-mgmt.sh install

libs-clean: ## clean library directory
	@echo "Cleaning library directory..."
	bash ${SCRIPTS_DIR}/lib-mgmt.sh clean

version: ## check circuitpython version
	@echo "Checking CircuitPython version..."
	bash ${SCRIPTS_DIR}/check-version.sh

upgrade: ## upgrade circuitpython
	@echo "Upgrading CircuitPython..."
	bash ${SCRIPTS_DIR}/upgrade.sh
