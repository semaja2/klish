# Setup build container
FROM debian:bookworm-slim AS build

# Install build tools, no clean up as we are in build container
RUN apt-get update && \
apt-get -y install build-essential libtool autoconf libxml2-dev expat pkg-config

# Create /build and copy source over
WORKDIR /build
COPY . .

# Download and install faux
RUN wget https://src.libcode.org/download/faux/faux-2.2.0.tar.xz && \
tar xf faux-2.2.0.tar.xz && cd faux-2.2.0 && ./configure --prefix=/usr && make && make install

# Build and install faux (requires cloning faux first)
#RUN cd /build/faux && ./autogen.sh && ./configure --prefix=/usr && make && make install

# Build and install klish, remove /build after
RUN cd /build && ./autogen.sh && ./configure --prefix=/usr --with-libxml2 && make && make install


# Build final container image
FROM debian:bookworm-slim

# Copy compiled over
COPY --from=build /usr/lib/libfaux* /usr/lib
COPY --from=build /usr/bin/faux* /usr/bin
COPY --from=build /usr/lib/libklish* /usr/lib
COPY --from=build /usr/lib/libtinyrl* /usr/lib
COPY --from=build /usr/bin/klish /usr/bin/klish
COPY --from=build /usr/bin/klishd /usr/bin/klishd

# Copy default configs
COPY klish.conf /etc/klish/klish.conf
COPY klishd.conf /etc/klish/klishd.conf

# Copy over example xml
COPY examples/simple/example.xml /etc/klish/example.xml

# Install depdendencies and cleanup
RUN apt-get update && \
apt-get install -y --no-install-recommends libxml2 less&& \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Start klishd in foreground with verbose, launch seperate docker exec to access client
# docker exec -it containername klish
CMD ["klishd", "-v", "-d"]