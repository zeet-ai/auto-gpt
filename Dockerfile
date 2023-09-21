# Use an official Python image as the base
FROM python:3.9-slim

# Set environment variables for Poetry
# 1. Make sure that the packages are installed globally within the docker image.
# 2. Do not ask for interactive confirmation of installs.
ENV POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_NO_INTERACTION=1

# Add the Poetry install path to the PATH
ENV PATH="$POETRY_HOME/bin:$PATH"

# Install Poetry
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && apt-get purge -y --auto-remove curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the Docker container
WORKDIR /app

# Copy the Python project and the poetry.lock file if it exists
COPY pyproject.toml poetry.lock* ./

# Install the project dependencies
RUN poetry install --no-dev

# Copy the rest of the project into the Docker container
COPY . .

CMD "python3 cli.py agent start forge && pause"