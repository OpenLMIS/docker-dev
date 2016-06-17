FROM anapsix/alpine-java:jdk8

WORKDIR /root
COPY installGradle.sh .
ENV GRADLE_USER_HOME /gradle
ENV GRADLE_OPTS -Dorg.gradle.daemon=true
RUN apk update && \
  apk add libstdc++ && \
  apk add bash && \
  apk add postgresql-client && \
  apk add nodejs && \
  apk add py-pip && \
  pip install --upgrade pip && \
  pip install transifex-client && \
  mkdir bin && \
  /bin/sh installGradle.sh

WORKDIR /app

VOLUME ["/app", "/gradle"]
EXPOSE 8080
CMD ["bash"]
