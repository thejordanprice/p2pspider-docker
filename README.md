# p2pspider-docker

## Prerequisites

- Docker
- Docker Compose

## Getting Started

### Building the Docker Image

1. **Clone the Repository**

   ```bash
   git clone https://github.com/thejordanprice/p2pspider-docker
   cd p2pspider-docker
   ```

2. **Configure Environment Variables**

   Create a `.env` file in the root of the project with your environment variables. Example:

   ```env
   REDIS_URI=redis://redis:6379
   MONGO_URI=mongodb://mongodb:27017/magnetdb
   SITE_HOSTNAME=127.0.0.1
   SITE_NAME=DHT Spider
   SITE_PORT=8080
   ```

3. **Build and Run the Containers**

   Run the following command to build and start the containers:

   ```bash
   docker-compose up --build
   ```

4. **Access the Application**

   The application will be accessible on the port specified in `SITE_PORT`. By default, this is `http://127.0.0.1:8080`.

### Using the Prebuilt Image

1. **Deploy with Docker Compose**

   Create a `docker-compose.yaml` file with the following configuration:

   ```yaml
   version: '3.8'

   services:
     mongodb:
       image: mongo:latest
       container_name: mongodb
       ports:
         - "127.0.0.1:27017:27017"
       volumes:
         - mongodb_data:/data/db
         - mongodb_configdb:/data/configdb
       networks:
         - p2pspider_network

     redis:
       image: redis:latest
       container_name: redis
       ports:
         - "127.0.0.1:6379:6379"
       volumes:
         - redis_data:/data
       networks:
         - p2pspider_network

     app:
       image: thejordanprice/p2pspider:latest
       container_name: p2pspider
       ports:
         - "${SITE_PORT:-8080}:${SITE_PORT:-8080}"
       environment:
         REDIS_URI: ${REDIS_URI:-redis://redis:6379}
         MONGO_URI: ${MONGO_URI:-mongodb://mongodb:27017/magnetdb}
         SITE_HOSTNAME: ${SITE_HOSTNAME:-127.0.0.1}
         SITE_NAME: ${SITE_NAME:-DHT Spider}
         SITE_PORT: ${SITE_PORT:-8080}
       depends_on:
         - mongodb
         - redis
       networks:
         - p2pspider_network

   networks:
     p2pspider_network:
       driver: bridge

   volumes:
     mongodb_data:
     mongodb_configdb:
     redis_data:
   ```

   Start the containers with:

   ```bash
   docker-compose up
   ```

2. **Deploy with Docker Run**

   You can also run the prebuilt image directly with Docker:

   ```bash
   docker run -d \
     --name mongodb \
     -p 127.0.0.1:27017:27017 \
     -v mongodb_data:/data/db \
     -v mongodb_configdb:/data/configdb \
     mongo:latest

   docker run -d \
     --name redis \
     -p 127.0.0.1:6379:6379 \
     -v redis_data:/data \
     redis:latest

   docker run -d \
     --name p2pspider \
     -p ${SITE_PORT:-8080}:${SITE_PORT:-8080} \
     -e REDIS_URI=${REDIS_URI:-redis://redis:6379} \
     -e MONGO_URI=${MONGO_URI:-mongodb://mongodb:27017/magnetdb} \
     -e SITE_HOSTNAME=${SITE_HOSTNAME:-127.0.0.1} \
     -e SITE_NAME=${SITE_NAME:-DHT Spider} \
     -e SITE_PORT=${SITE_PORT:-8080} \
     --link mongodb --link redis \
     thejordanprice/p2pspider:latest
   ```

   **Note**: Replace environment variable values or use default values as needed.

## Dockerfile

The `Dockerfile` sets up the application environment and runs `daemon.js` and `webserver.js`. It does the following:

- Uses the `node:18` base image.
- Sets the working directory to `/app`.
- Copies the repository contents into the container.
- Installs dependencies with `npm install`.
- Exposes port 8080.
- Starts the application with `npm start`.

## docker-compose.yaml

The `docker-compose.yaml` file defines the following services:

- **mongodb**: Uses the official MongoDB image, exposing port 27017.
- **redis**: Uses the official Redis image, exposing port 6379.
- **app**: Builds the Docker image from the `Dockerfile`, depends on `mongodb` and `redis`, and exposes the application on port 8080.

## Troubleshooting

- **Port Forwarding**: Ensure that port 6881 is properly forwarded in your router or firewall settings. This is necessary to collect metadata effectively, as it allows incoming connections to reach your application. Without this port forwarding, the application may not receive the data it needs.
- **Connection Refused**: Ensure that the Redis and MongoDB services are running and accessible. Verify the connection settings in your environment.
- **Environment Variable Issues**: Ensure that environment variables are correctly set and match your configuration.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
