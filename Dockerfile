FROM node:18-bullseye-slim

RUN apt update && apt install -y make

COPY package.json yarn.lock Makefile ./
RUN make install-deps-dev
