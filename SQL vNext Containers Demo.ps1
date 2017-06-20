﻿# SQL Server vNext on Windows Server Containers - Docker demo
# Thank you Keith Mayer --> https://github.com/robotechredmond/Azure-PowerShell-Snippets/blob/master/SQL%20vNext%20Containers%20Demo.ps1

# Set variables
$acrRegistry = "mcollierwindevug.azurecr.io"
$acrUser = "mcollierwindevug"

# Supply Passwords to use. Get ACR password from Azure portal or AZ CLI.
$saPassword = (Get-Credential -Message 'Enter sa password for database.').GetNetworkCredential().Password
$acrPassword = "myL+7ffVtxPu+JOdfvTEFSPgIoTh9sg6"

# Search Docker Hub for MS SQL Server container images
docker search microsoft/mssql

# Pull MS SQL Server vNext for Windows container image to a local copy
docker pull microsoft/mssql-server-windows-developer

# Display list of local images
docker images

# Start a new container from the container image
docker run -d -p 1433:1433 -e sa_password=$saPassword -e ACCEPT_EULA=Y microsoft/mssql-server-windows-developer

# Display running containers
docker ps

# Select a container
$containerID = (docker ps -a|Out-GridView -PassThru).Substring(0, 12)

# Get container IP address - connect to this address from within the local VM using SSMS
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerID

#-- TSQL - create sample database
CREATE DATABASE [SampleDB01];
GO
USE [SampleDB01];
GO
CREATE TABLE dbo.Table01
(PKID INT IDENTITY(1, 1) PRIMARY KEY,
    ColA VARCHAR(10),
    ColB VARCHAR(10),
    ColC DATETIME);
GO
INSERT INTO dbo.Table01
(ColA, ColB, ColC)
VALUES
(REPLICATE('A', 10), REPLICATE('B', 10), GETUTCDATE());
GO 10

#-- TSQL - Show records with random data in table in sample database
SELECT * FROM dbo.Table01

# Stop the container
docker stop $containerID

# Commit the container to a new image
docker commit $containerID sampleimage01

# Show list of local images
docker images

# Start new container from committed image
docker run -d -p 1433:1433 -e sa_password=$saPassword -e ACCEPT_EULA=Y sampleimage01


# Connect to database via SSMS; show SampleDB01.dbo.Table01
$containerID = (docker ps -a|Out-GridView -PassThru).Substring(0, 12)
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerID


# Login to Azure Container Registry
docker login $acrRegistry -u $acrUser -p $acrPassword

# Tag a container image with a repository
docker tag sampleimage01 ${acrRegistry}/samples/sql:v1

# Show list of local images
docker images

# Push tagged container image to registry
docker push ${acrRegistry}/samples/sql:v1

docker ps -a
docker stop $containerID
docker rm $containerID

# Remove container images
docker rmi sampleimage01  ${acrRegistry}/samples/sql:v1

# Pull container image from Azure container registry
docker pull ${acrRegistry}/samples/sql:v1

# Logout from Registry
docker logout $acrRegistry