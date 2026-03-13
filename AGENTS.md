# CLAUDE.md

## What this is

A collection of Dockerfiles for the databio organization. Each subdirectory under `Dockerfiles/` defines one Docker image with one or more version tags.

## Repository structure

```
Dockerfiles/{image-name}/
  ├── {version}        # Dockerfile for a specific version (e.g., "5.9", "22.04")
  ├── latest           # Symlink to the current default version
  └── README.md        # Optional notes
bin/                   # Build helper scripts
tags/                  # Version auto-detection scripts (rarely used)
Makefile               # Build automation
```

## How images are named

- Registry: `docker.io/databio` (primary), `ghcr.io/databio` (secondary)
- Image name = directory name under `Dockerfiles/`
- Tag = filename within that directory (e.g., `5.9`, `latest`, `22.04`)

## Adding a new image version

1. Create the Dockerfile at `Dockerfiles/{image}/{version}` (the file IS the Dockerfile, named by its tag)
2. Update the `latest` symlink: `ln -sf {version} Dockerfiles/{image}/latest`
3. Build: `make docker.io/databio/{image}/{version}`
4. Push: `docker push databio/{image}:{version}`

## Common Dockerfile patterns

- Base images: `ubuntu:20.04`, `ubuntu:22.04`, `python:3.x`
- Use `ARG DEBIAN_FRONTEND=noninteractive` and `ENV TZ=America/New_York` for unattended installs
- Combine `apt-get update && apt-get install` in single RUN layers
- Set PATH for installed tools: `ENV PATH "/tool/bin:${PATH}"`

## Build commands

```bash
make docker.io/databio/{image}/{tag}            # Build
make docker.io/databio/{image}/{tag}-nocache     # Build without cache
docker push databio/{image}:{tag}                # Push to DockerHub
```

## No CI/CD

Builds are manual. There are no GitHub Actions workflows.
