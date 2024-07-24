# p2pspider-docker

## Prerequisites

- Docker
- Docker Compose

## Getting Started

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
- **Connection Refused**: Ensure that the Redis and MongoDB services are running and accessible. Verify the connection settings in your `.env` file.
- **Environment Variable Issues**: Ensure that your `.env` file is correctly formatted and placed in the root directory.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
