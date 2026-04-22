# footxbar

A toy package for practising Docker, GHCR, and Poetry-based releases.

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Running the API

Download the compose file and start the container:

```bash
curl -O https://raw.githubusercontent.com/AaronCiuffo245484/sphinx_practice/main/docker-compose.yml
docker compose up
```

Docker will pull the image automatically. The API will be available at `http://localhost:8000`.

## Testing the API

Add one to a number:

```bash
curl http://localhost:8000/add/5
```

Check the running version:

```bash
curl http://localhost:8000/version
```

## Stopping the API

```bash
docker compose down
```

## Development

Clone the repository and see the [Makefile](Makefile) for available commands:

```bash
make help
```

To release a new version:

```bash
make release-patch   # bug fixes
make release-minor   # new features, also publishes to PyPI
make release-major   # breaking changes, also publishes to PyPI
```