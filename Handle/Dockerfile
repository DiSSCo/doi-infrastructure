FROM ubuntu:22.04

RUN adduser -disabled-password -u 1000 usr
COPY --chown=usr:usr hdl_server /server/hdl_server/
COPY --chown=usr:usr handle-9.3.0/ /server/handle-9.3.0/

EXPOSE 2641/tcp
EXPOSE 2641/udp
EXPOSE 8000/tcp

# Install OpenJDK-11
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless && \
    apt-get clean;

ENTRYPOINT ["/server/handle-9.3.0/bin/hdl-server", "/server/hdl_server"]
