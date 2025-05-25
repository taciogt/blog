# Makefile for blog project

## Define phony targets (targets that don't represent files)
.PHONY: all clean help

.DEFAULT_GOAL := help

help:	## Show this help
	@grep -E '^[a-zA-Z_/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all:	## Build the blog project
	@echo "Building blog project..."

ci/build:	## Builds the blog using the same parameters as the production environment
	@cd software-engineering && \
	hugo --gc --minify

setup: .setup-timestamp	## Setups the local environment for development

.setup-timestamp: Makefile
	@echo "Makefile has been modified!"
	@echo "Rebuilding with new rules..."
	@$(MAKE) all
	@brew install hugo
	@touch $@

# Clean target
clean:	## Remove generated files and reset environment
	@echo "Cleaning up..."
	@rm -f .setup-timestamp

run: setup	## Starts the Hugo development server
	@cd software-engineering && \
	hugo server -D
