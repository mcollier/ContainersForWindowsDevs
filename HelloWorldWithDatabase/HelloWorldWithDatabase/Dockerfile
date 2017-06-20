FROM microsoft/aspnet
ARG source


COPY bootstrap.ps1 /

WORKDIR /inetpub/wwwroot

COPY ${source:-obj/Docker/publish} .


ENTRYPOINT ./bootstrap.ps1
