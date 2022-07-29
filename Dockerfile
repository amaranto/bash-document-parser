FROM ubuntu:22.04

ENV SCRIPTS_FOLDER=/opt/scripts
ENV SOURCE_FOLDER=/mnt/texts
ENV WGET_ALLOW_INSECURE=true

WORKDIR /opt/scripts

RUN apt update -y
RUN apt install -y wget

COPY ./examples /mnt/texts
COPY ./scripts /opt/scripts
RUN chmod -R +x /opt/scripts

ENTRYPOINT [ "/opt/scripts/entrypoint.sh"]