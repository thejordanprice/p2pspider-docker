# Use a base image with Node.js
FROM node:18

# Install Git (needed for cloning the repository)
RUN apt-get update && apt-get install -y git

# Clone the GitHub repository
RUN git clone https://github.com/thejordanprice/p2pspider.git /app

# Set the working directory
WORKDIR /app

# Install Node.js dependencies
RUN npm install

# Expose the necessary ports
EXPOSE 6881 8080

# Run the daemons
CMD ["sh", "-c", "node daemon.js & node webserver.js"]
