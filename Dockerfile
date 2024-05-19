FROM alpine:3.19
ARG LUA_VER=5.4.6
ARG LLS_VER=3.9.1
ENV PATH="/root/bin:$PATH"
RUN apk add --no-cache --virtual .build-deps \
    g++ \
    make \
  && cd /tmp \
  && wget "https://www.lua.org/ftp/lua-$LUA_VER.tar.gz" \
  && tar -xzf "lua-$LUA_VER.tar.gz" \
  && cd "/tmp/lua-$LUA_VER" \
  && make && make install && cd .. \
  && wget "https://github.com/LuaLS/lua-language-server/releases/download/$LLS_VER/lua-language-server-$LLS_VER-linux-x64-musl.tar.gz" \
  && tar -xzf "lua-language-server-$LLS_VER-linux-x64-musl.tar.gz" -C ~ \
  && rm -rf /tmp/* \
  && apk del .build-deps \
  && apk add --no-cache libgcc
CMD ["lua-language-server"]
