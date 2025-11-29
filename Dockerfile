FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y \
        lua5.2 \
        luarocks \
        gcc \
        make \
        build-essential \
        pkg-config \
        liblua5.2-dev \
        && luarocks install luasocket \
        && luarocks install dkjson \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

ENV PORT=8080
CMD ["lua5.2", "Server.lua"]
