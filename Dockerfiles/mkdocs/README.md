How to upgrade this mkdocs thing

Just make a new Dockerfile in here, pulling from the latest Python release. Build it with `make docker.io/databio/mkdocs/<name>`, where `<name>` is what you named this latest version. I guess it makes sense to name after the python version, or maybe after the latest mkdocs version for that version of python.