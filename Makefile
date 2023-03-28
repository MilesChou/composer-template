#!/usr/bin/make -f

PROCESSORS_NUM := $(shell getconf _NPROCESSORS_ONLN)
GLOBAL_CONFIG := -d memory_limit=-1

.PHONY: all
all: test

build:
	mkdir -p build

.PHONY: clean
clean:
	git clean -Xfq build

.PHONY: clean-all
clean-all: clean
	rm -rf ./vendor
	rm -rf ./composer.lock

.PHONY: check
check: build
	php ${GLOBAL_CONFIG} vendor/bin/phpcs --parallel=${PROCESSORS_NUM} --report-junit=build/phpcs.xml

.PHONY: test
test: clean check
	php ${GLOBAL_CONFIG} vendor/bin/phpunit --no-coverage

.PHONY: coverage
coverage: test
	php ${GLOBAL_CONFIG} -d xdebug.mode=coverage vendor/bin/phpunit
	@if [ "`uname`" = "Darwin" ]; then open build/coverage/index.html; fi
