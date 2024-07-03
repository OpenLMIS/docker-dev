FROM alpine:3.12

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
  npm install -g raml-cop@5.0.0

COPY sync_transifex.sh /transifex/sync_transifex.sh
COPY wait-for-postgres.sh /config/wait-for-postgres.sh
RUN chmod +x /config/wait-for-postgres.sh

# Create builder user that can mirror user from docker host
ENV USER=build
ENV GROUPNAME=$USER
ENV UID=1001
ENV GID=1001
RUN addgroup \
  --gid "$GID" \
  "$GROUPNAME" \
&&  adduser \
  --disabled-password \
  --home "/$USER" \
  --gecos "" \
  --ingroup "$GROUPNAME" \
  --uid "$UID" \
  $USER
ENV PATH="$PATH:/$USER/.local/bin"

USER $USER
WORKDIR /$USER

COPY install_gradle.sh .
ENV GRADLE_USER_HOME /$USER/gradle
ENV GRADLE_OPTS -Dorg.gradle.daemon=true
ENV GIT_PYTHON_GIT_EXECUTABLE /usr/bin/git

RUN pip install --upgrade pip && \
  pip install transifex-client && \
  mkdir bin && \
  /bin/sh install_gradle.sh

WORKDIR /app

VOLUME ["/app", "/gradle"]

EXPOSE 8080

CMD ["bash"]
