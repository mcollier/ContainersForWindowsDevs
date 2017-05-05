FROM microsoft/mssql-server-windows-developer

# SQL environmental variables
ENV sa_password "Password123"
ENV attach_dbs []
ENV ACCEPT_EULA "Y"

# Copy SQL scripts for setting up database and tables
COPY setup-database.sql /

WORKDIR /

# Create blog application database and tables
RUN powershell sqlcmd -S localhost,1433 -i setup-database.sql