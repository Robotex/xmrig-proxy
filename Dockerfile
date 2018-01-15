FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig-proxy proxy
COPY . xmrig-proxy
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        cmake \
        libuv-dev \
        uuid-dev \
        libuuid \
        util-linux-dev \
        build-base && \
      cd xmrig-proxy && \
      mkdir build && \
      cmake -DWITH_HTTPD=OFF -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        util-linux-dev \
        cmake
USER proxy
WORKDIR    /xmrig-proxy
ENTRYPOINT  ["./xmrig-proxy"]