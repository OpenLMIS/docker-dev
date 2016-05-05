FROM anapsix/alpine-java:jdk8

WORKDIR /root
COPY installGradle.sh .
COPY gradle.properties .gradle/
RUN apk update && \
  apk add libstdc++ && \
  apk add bash && \
  mkdir bin && \
  /bin/sh installGradle.sh

WORKDIR /app
VOLUME /app

EXPOSE 8080
ENTRYPOINT ["gradle"]
