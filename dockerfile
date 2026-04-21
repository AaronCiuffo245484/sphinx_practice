# Dockerfile

# Base image: slim Python 3.10 to keep the image size small
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependency manifest, readme, and source code into the container
COPY pyproject.toml .
COPY README.md .
COPY src/ src/

# Install Poetry, disable virtualenv creation (not needed inside a container),
# and install only production dependencies
RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --only main

# Start the FastAPI app on all interfaces so it is reachable from outside the container
CMD ["uvicorn", "footxbar:app", "--host", "0.0.0.0", "--port", "8000"]