## Basics of Docker Builds with NodeJS Redux example ##

* https://docs.docker.com/language/nodejs/
* https://docs.docker.com/develop/develop-images/build_enhancements/

## Using this video to develop Redux ##

* https://www.youtube.com/watch?v=rRg7DMAXC78

$ DOCKER_BUILDKIT=1 docker build .

## Following Dockerfile best practices ##

* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

## Using the gist Makefile to run make build ##

* https://gist.github.com/mpneuried/0594963ad38e68917ef189b4e6a269db

## Using multi-stage builds

* https://docs.docker.com/develop/develop-images/multistage-build/

## Sample output ##

* steps:
 
=> echo -n '[credential string]' > ~/.password.txt

# make
help                           This help.
up                             Run container on port configured in `config.env` (Alias to run)
build                          Build the release and develoment container. The development
run                            Run container on port configured in `config.env`
stop                           Stop and remove a running container
clean                          Clean the generated/compiles files
version                        Output the current version
tag                            Generate container tags for the `{version}` ans `latest` tags
tag-latest                     Generate container `{version}` tag
tag-version                    Generate container `latest` tag
release                        Make a release by building and publishing the `{version}` ans `latest` tagged containers to Docker HUB
publish                        Publish the `{version}` ans `latest` tagged containers to Docker Hub
publish-latest                 Publish the `latest` taged container to Docker Hub
publish-version                Publish the `{version}` taged container to Docker Hub
repo-login                     Auto login to Docker Hub container registry

# make build

## lab 1 ##

* https://www.youtube.com/watch?v=rRg7DMAXC78
* branch feature/1-Starter
  https://github.com/boonchu/react-redux-tutorial/tree/feature/1-Starter
