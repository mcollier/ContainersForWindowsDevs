FROM microsoft/aspnet
ARG source

# Environment variables set in docker-compose or Dockerfile are set for the process of the container and not SYSTEM variables.
# See http://stackoverflow.com/questions/39978342/docker-for-windows-asp-net-site-unable-to-read-environment-variables-defined-in
RUN setx /m CONNECTION_STRING "Server=db;Database=SampleDB01;User ID=sa; Password=Password123;Integrated Security=False"

RUN iisreset

WORKDIR /inetpub/wwwroot
COPY ${source:-obj/Docker/publish} .
