# Use an official Node.js runtime as a parent image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Ensure all scripts have executable permissions
RUN chmod +x node_modules/.bin/*

# Build the React app for production
RUN npm run build

# Install a simple server to serve the static files
RUN npm install -g serve

# Expose the port the app will run on
EXPOSE 3000

# Define the command to serve the app
CMD ["serve", "-s", "build"]
