FROM alpine:3.12

WORKDIR /root

COPY install_gradle.sh .
ENV GRADLE_USER_HOME /gradle
ENV GRADLE_OPTS -Dorg.gradle.daemon=true
ENV GIT_PYTHON_GIT_EXECUTABLE /usr/bin/git

RUN apk update && \
  apk add libstdc++ && \
  apk add bash && \
  apk add openjdk8 && \
  apk add postgresql-client && \
  apk add postgresql && \
  apk add nodejs-current-npm && \
  apk add wget && \
  apk add curl && \
  apk add py-pip && \
  apk add git && \
  pip install --upgrade pip && \
  mkdir bin && \
  npm install -g raml-cop@5.0.0 && \
  /bin/sh install_gradle.sh

WORKDIR /app

COPY sync_transifex.sh /transifex/sync_transifex.sh
COPY wait-for-postgres.sh /config/wait-for-postgres.sh
RUN chmod u+x /config/wait-for-postgres.sh
RUN curl -o- https://raw.githubusercontent.com/transifex/cli/master/install.sh | bash
VOLUME ["/app", "/gradle"]

EXPOSE 8080
CMD ["bash"]
