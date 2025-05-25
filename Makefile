# Makefile for blog project

## Define phony targets (targets that don't represent files)
#.PHONY: all clean makefile-changed

# Default target
all:
	@echo "Building blog project..."

ci/build:
	@cd software-engineering && \
	hugo --minify

setup: .setup-timestamp

.setup-timestamp: Makefile
	@echo "Makefile has been modified!"
	@echo "Rebuilding with new rules..."
	@$(MAKE) all
	@brew install hugo
	@touch $@

# Clean target
clean:
	@echo "Cleaning up..."
	@rm -f .setup-timestamp

