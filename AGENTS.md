# AGENTS.md

## Building and pushing a Docker image

```bash
cd /path/to/dockerfiles
make docker.io/databio/{image}/{tag}
docker push databio/{image}:{tag}
```

Example: `make docker.io/databio/looper/latest && docker push databio/looper:latest`

To rebuild without cache: `make docker.io/databio/{image}/{tag}-nocache`

## Adding a new image or version

1. Create the Dockerfile at `Dockerfiles/{image}/{version}` (the filename IS the tag)
2. Symlink latest: `ln -sf {version} Dockerfiles/{image}/latest`
3. Build and push as above

## Structure

- `Dockerfiles/{image}/{tag}` - Each file is a Dockerfile named by its version tag
- `bin/build.sh` - Called by Make to do the actual `docker build`
- Registries: `docker.io/databio` (primary), `ghcr.io/databio` (secondary)
- No CI/CD - all builds are manual
