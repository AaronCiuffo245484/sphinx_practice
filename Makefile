# Makefile
.PHONY: docs docs-open tests lint build upload bump-patch bump-minor bump-major docker-build docker-push release-patch release-minor release-major help

REGISTRY := ghcr.io/aaronciuffo245484
IMAGE := footxbar
VERSION := $(shell poetry version -s)

docs:
	poetry run sphinx-apidoc -f -o docs/reference src/footxbar
	poetry run sphinx-build -b html -W docs/ docs/_build/html

docs-open:
	poetry run sphinx-apidoc -f -o docs/reference src/footxbar
	poetry run sphinx-build -b html -W docs/ docs/_build/html
	open docs/_build/html/index.html

tests:
	poetry run pytest tests/ -v

lint:
	poetry run pre-commit run --all-files

py-build:
	poetry run python -m build

pypi-upload:
	poetry run twine upload --repository testpypi dist/*

bump-patch:
	poetry version patch

bump-minor:
	poetry version minor

bump-major:
	poetry version major

docker-build:
	docker buildx build --platform linux/amd64,linux/arm64 \
		-t $(REGISTRY)/$(IMAGE):$(VERSION) \
		-t $(REGISTRY)/$(IMAGE):latest \
		--push .

release-patch:
	poetry version patch
	git add pyproject.toml
	git commit -m "chore: bump version to $$(poetry version -s)"
	git push
	$(MAKE) docker-build

release-minor:
	poetry version minor
	git add pyproject.toml
	git commit -m "chore: bump version to $$(poetry version -s)"
	git push
	$(MAKE) docker-build
	$(MAKE) build
	$(MAKE) upload

release-major:
	poetry version major
	git add pyproject.toml
	git commit -m "chore: bump version to $$(poetry version -s)"
	git push
	$(MAKE) docker-build
	$(MAKE) build
	$(MAKE) upload
help:
	@grep -E '^[a-zA-Z_-]+:' Makefile | sed 's/:.*//' | sort
