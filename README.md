# OpenLMIS Dockerized Development Image

From alpine-java, exposes gradle for building Java 8 applications.

/app expects Gradle app mounted in.

Port 8080 exposed

## Examples

Build a gradle application (and throw container away when done):
```shell
> docker run -it --rm -v $(pwd):/app openlmis/dev build
```

Use gradle interactively:
```shell
> docker run -it --rm --entrypoint /bin/bash -v $(pwd):/app openlmis/dev
```
