# Get the IP address
$containerID = (docker ps -a|Out-GridView -PassThru).Substring(0, 12)
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerID


# Switch container environment 
# See https://stefanscherer.github.io/run-linux-and-windows-containers-on-windows-10/
& 'C:\Program Files\Docker\Docker\DockerCli.exe' -SwitchDaemon
