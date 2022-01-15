# WordPress Docker Stack

This Docker stack initializes WordPress, MariaDB, Redis for object caching, and a 3 node Elastic Search cluster.

# Initial Setup

Step 1: You will need to generate ssl certificates in order to use this stack either locally or in production and then update ```.env``` environmental configuration with the appropriate variables.

Step 2: Update your ```.env``` dotfile for the enviornment that your working in (development, staging, production).

Step 3: Start docker and launch this stack using ```docker-compose```.

## Step 1: Development - Generate Local Certificates

Install [mkcert](https://github.com/FiloSottile/mkcert#installation) and then run the mkcert command in the ```./certs``` directory. Update the environmental configuration for Nginx SSL as needed.

```
$ mkcert -install
Created a new local CA 💥
The local CA is now installed in the system trust store! ⚡️
The local CA is now installed in the Firefox trust store (requires browser restart)! 🦊

$ mkcert wordpress.local "*.wordpress.local"

Created a new certificate valid for the following names 📜
 - "wordpress.local"
 - "*.wordpress.local"

The certificate is at "./wordpress.local+1.pem" and the key at "./wordpress.local+1-key.pem" ✅
```

## Step 1: Production and Staging: Use SSL Certificates

Download a copy your certificate and key from your certificate provider to ```./certs``` and update environment variables in ```.env``` as needed. The provided Nginx template in ```./templates/default.conf.template``` will use the certificates you specify in ```.env```.

## Step 2: Environment Configuration

This stack can be configured for different environments using the ```.env``` dotfile. See ```.env-template``` for all variables available. Copy ```.env-template``` to ```.env``` and update as necessary. This is where you change database username and password, update nginx configuration, specify which docker image versions to use for each service, etc.

### Step 3: Start Docker and Start Stack

In a development environment, you can download [Docker Desktop](https://www.docker.com/products/docker-desktop). On other systems, you will need to install Docker Engine and start the dameon. 

Once Docker has been started, you can issue ```docker-compose up -d``` and the stack will start. Please see below for more information on using docker-compose.
## Docker Compose Basics

View the [docker compose documentation.](https://docs.docker.com/compose/)

This stack can be used for local development, staging, and production. If running locally, you will need to map domains in your os hosts file or use a tool like dnsmasq to map domains automatically. The development environment on this stack is configured to use https://wordpress.local. You will need to generate local certificates using ```mkcert``` in order to use https.

Start Docker and then run ```docker compose up -d``` to bring the stack up and detach it from stdout. Here are some basic commands.

If you need to start the elastic search services you have two options. You can start them together with WordPress or separately.

This will start the main stack without elastic search.

```
docker-compose up -d
```

This will start the main stack with elastic search.

```
docker compose up -f docker-compose.yml docker compose docker-compose.elastic.yml -d
```

**Common Docker Compose Commands**

```
docker-compose up -d            # start services

docker-compose ps               # view service info

docker-compose logs nginx       # view nginx logs 

docker-compose stop             # stop containers

docker-compose rm               # remove containers
```
