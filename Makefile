.PHONY: docs docs-open tests lint

docs:
	poetry run sphinx-apidoc -f -o docs/reference src/foobar
	poetry run sphinx-build -b html -W docs/ docs/_build/html

docs-open:
	poetry run sphinx-apidoc -f -o docs/reference src/foobar
	poetry run sphinx-build -b html -W docs/ docs/_build/html
	open docs/_build/html/index.html

tests:
	poetry run pytest tests/ -v

lint:
	poetry run pre-commit run --all-files
