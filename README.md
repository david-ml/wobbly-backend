# wobbly-backend

## Developer Quickstart
- Install Docker
- Clone this repo
- From the base `wobbly-backend` directory, run `docker-compose up --build`. This will build the underlying Docker images and execute the instructions in `docker-compose.yml`.


## Directions

### Fill in Django secret key

`$  mv bin/environment.sh.example bin/environment.sh`

```sh
#bin/environment.sh:

#! /bin/bash

export DOCKER_IMAGE=wobbly-backend-image
export DJANGO_SECRET_KEY= <Django secret key    # (generate <= 32 characters)>
export DEBUG=True
```

### Make scripts executable

`$ chmod +x ./bin/*.sh`

### Set environment variables (for development only)

`$ source bin/environment.sh`

### Build Docker image

`$ bin/build-docker.sh -d`

### Start Docker image

`$ bin/start-docker.sh -d`

Once it starts up the IP address and port will be displayed. Opening a browser to the address  will connect you sto the DJango server.
