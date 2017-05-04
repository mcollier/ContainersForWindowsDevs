<#
## Demo Reset
docker rm -f $(docker ps -a -q)

# Cache Images
docker pull microsoft/windowsservercore
docker pull microsoft/nanoserver:latest
docker pull microsoft/dotnet:nanoserver
docker pull microsoft/dotnet-samples:dotnetapp-nanoserver
docker pull microsoft/iis
docker pull microsoft/aspnet
docker pull microsoft/mssql-server-windows
#>

##1 - Show Docker running on Windows 10

# Show the Client and Server version for Docker.
docker version
	
# Show the Server OS/Arch setting, either 'windows/amd64' or 'linux/amd64'.
& 'C:\Program Files\Docker\Docker\DockerCli.exe' -SwitchDaemon	

# Show the Server OS/Arch setting has changed.
docker version
	
# Switch to Hyper-V Manager	Show the �MobyLinuxVM� running.

# Switch back to being able to run Windows containers.
& 'C:\Program Files\Docker\Docker\DockerCli.exe' -SwitchDaemon	

# List images in the local repository.
docker images	

# Get an image from Docker Hub.	
docker pull microsoft/dotnet-samples:dotnetapp-nanoserver	

# Remove a local image
docker rmi microsoft/iis	


##2 Manage Containers

# Run a container
docker run microsoft/dotnet-samples:dotnetapp-nanoserver	

# List all containers, including stopped containers
docker ps -a	

# Run an existing, stopped container
$containerID = (docker ps -a |Out-GridView -PassThru).Substring(0, 12)
docker start -ia $containerID


##3 Dockerize a .NET Console Application

# Move to the project directory.
cd 'C:\Projects\ContainersForWindowsDevs\HelloWorldConsole\HelloWorldConsole\'

# Create the image (don't forget the '.')
docker build -t helloworldconsole:stirtrek2017 .

# Show the image just created.
docker images

# Run the image, specifying the input parameter. Using "--rm" will remove the container after it exits.
docker run --rm helloworldconsole:stirtrek2017 "mike"

# Show the container is not available
docker ps -a

##4 - SQL Server vNext in a Container
# Go to "SQL vNext Containers Demo.ps1"


##5 - Visual Studio 2017 (Docker Tools)
# See Demo Script.docx


##6 - Docker Compose w/ ASP.NET MVC and SQL Server
# See Demo Script.docx