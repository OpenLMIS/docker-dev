# OpenLMIS Dockerized Development Image

Image for launching (non-)interactive containers with gradle suitable for developing OpenLMIS v3+ Services.

Based off of alpine-java.

## Volumes

- `/app` expects a Gradle project to be mounted in.  It is also the default working directory.
- `/gradle` is a volume for sharing a common Gradle cache.  Apart from the project-level cache that will be stored
in the `/app` volume, this one is useful for the typical startup of gradle and for sharing that startup in the
build step of other OpenLMIS Services when appropriate.  This should reduce frequent downloads.

## Ports

- 8080 - typical HTTP port
- 8000 - typical JVM debug port

# Environment, EntryPoint & Command

- GRADLE_OPTS enables the daemon and that's all.  This is left intentionally short as other environments (e.g. CI)
will want to disable the daemon.
- EntryPoint is, like alpine-java, undefined
- command is bash

## Examples

Build a gradle application (and throw container away when done):
```shell
> docker run -it --rm --entrypoint gradle -v $(pwd):/app openlmis/dev build
```

Use interactively:
```shell
> docker run -it --rm -v $(pwd):/app openlmis/dev
```

Interactive using a named volume for the gradle cache:
```shell
> docker run -it --rm -v gradlecache:/gradle -v $(pwd):/app openlmis/dev
```

Typical development day:
```shell
> docker run -it --rm -p 8080:8080 -v gradlecache:/gradle -v $(pwd):/app openlmis/dev
$ gradle clean build
```
Most interactions should occur through docker-compose.

## Tech

- JDK 1.8+
- Gradle 4.10+
- Node 8+
- PSQL 10+
- RAML-Cop 5
