ARG VARIANT="20.10.0-bookworm-slim"

FROM node:${VARIANT}
WORKDIR /workspace

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends make

ADD ./ ./
RUN make install-deps-dev
