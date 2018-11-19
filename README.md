# docker-easy-pull
Docker image to circumvent required machine-wide flags to pull via proxy and/or with certs

## Example build command
docker build . -t docker-easy-pull;

## Example run command
docker run --rm --privileged --name docker-easy-pull -e "PULL_TAG=busybox:latest" -e "OUTPUT_FILE=/images/busybox.tar" -v /c/Users/Josh/images:/images docker-easy-pull
