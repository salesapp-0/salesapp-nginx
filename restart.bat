@echo off

set CONTAINER_NAME=salesapp_nginx
set IMAGE_NAME=salesapp_nginx

for /f "tokens=*" %%i in ('docker ps -q -f name=%CONTAINER_NAME%') do set CONTAINER_ID=%%i
if defined CONTAINER_ID (
    echo Stopping the container: %CONTAINER_NAME%
    docker stop %CONTAINER_NAME%
)

for /f "tokens=*" %%i in ('docker ps -a -q -f name=%CONTAINER_NAME%') do set CONTAINER_ID=%%i
if defined CONTAINER_ID (
    echo Removing the container: %CONTAINER_NAME%
    docker rm %CONTAINER_NAME%
)

for /f "tokens=*" %%i in ('docker images -q %IMAGE_NAME%') do set IMAGE_ID=%%i
if defined IMAGE_ID (
    echo Removing the image: %IMAGE_NAME%
    docker rmi %IMAGE_NAME%
)

echo Building the image: %IMAGE_NAME%
docker build -t %IMAGE_NAME% .

echo Running the container: %CONTAINER_NAME%
docker run -d --name %CONTAINER_NAME% -p 80:80 %IMAGE_NAME%

echo Done!