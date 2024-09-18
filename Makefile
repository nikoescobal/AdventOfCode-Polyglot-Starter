.DEFAULT_GOAL := help

# Detect the current directory
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
y := $(firstword $(MAKECMDGOALS))
d := $(word 2, $(MAKECMDGOALS))

# Strip y and d from make goals to avoid errors when executing commands
$(eval $(call strip_and_delete_from_goals, $(y)))
$(eval $(call strip_and_delete_from_goals, $(d)))

# Ensure y and d are passed
ifneq ($(y),)
  ifneq ($(d),)
    DATE_ARGS := $(y) $(d)
  else
    $(error "Please pass both YEAR and DAY")
  endif
else
  $(error "Please pass both YEAR and DAY")
endif

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make run LANG=[clojure|javascript|ruby|python] YYYY DD    - Run the specified day's solution for the specified language"
	@echo "  make create YYYY DD [FORCE=--force]                      - Create solution files; use FORCE=--force to overwrite existing files"
	@echo "  make input YYYY DD [FORCE=--force]                       - Create input files; use FORCE=--force to overwrite existing files"
	@echo "  make run_all YYYY DD                                     - Run the specified day's solution in all languages"

.PHONY: run
run:
	@echo "Running $(LANG) solution for Day $(d), $(y):"
	@if [ "$(LANG)" = "clojure" ]; then \
		cd "$(MAKEFILE_DIR)" && ./aoc_manager.sh run clojure $(DATE_ARGS); \
	elif [ "$(LANG)" = "javascript" ]; then \
		./aoc_manager.sh run javascript $(DATE_ARGS); \
	elif [ "$(LANG)" = "ruby" ]; then \
		./aoc_manager.sh run ruby $(DATE_ARGS); \
	elif [ "$(LANG)" = "python" ]; then \
		./aoc_manager.sh run python $(DATE_ARGS); \
	elif [ "$(LANG)" = "rust" ]; then \
		cd "$(MAKEFILE_DIR)" && ./aoc_manager.sh run rust $(DATE_ARGS); \
	elif [ "$(LANG)" = "go" ]; then \
		cd "$(MAKEFILE_DIR)" && ./aoc_manager.sh run go $(DATE_ARGS); \
	else \
		echo "Unsupported language: $(LANG)"; \
		exit 1; \
	fi

.PHONY: create
create:
	@echo "Creating solution files for Day $(d), $(y):"
	@./aoc_manager.sh create $(DATE_ARGS) $(FORCE)

.PHONY: input
input:
	@echo "Creating input file for Day $(d), $(y):"
	@./aoc_manager.sh input $(DATE_ARGS) $(FORCE)

.PHONY: run_all
run_all:
	@echo "Running all language solutions for Day $(d), $(y):"
	@./aoc_manager.sh run clojure $(DATE_ARGS)
	@./aoc_manager.sh run javascript $(DATE_ARGS)
	@./aoc_manager.sh run ruby $(DATE_ARGS)
	@./aoc_manager.sh run python $(DATE_ARGS)
	@./aoc_manager.sh run rust $(DATE_ARGS)
	@./aoc_manager.sh run go $(DATE_ARGS)
