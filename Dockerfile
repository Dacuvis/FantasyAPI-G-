FROM debian:bullseye-slim

# 1. Install dependencies
RUN apt-get update && \
    apt-get install -y lua5.2 luarocks && \
    luarocks install luasocket && \
    luarocks install dkjson && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Copy source code ke image
WORKDIR /app
COPY . .

# 3. Expose port Railway akan connect ke variable PORT
ENV PORT=8080

# 4. Jalankan server Lua
CMD ["lua5.2", "Server.lua"]
