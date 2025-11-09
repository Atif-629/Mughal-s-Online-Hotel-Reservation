# Use official Node.js image as base
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package files first (for better caching)
COPY package*.json ./

# Install dependencies with legacy peer deps flag
RUN npm install --legacy-peer-deps

# Copy all application files
COPY . .

# Expose port 3000 (the port your app runs on)
EXPOSE 3000

# Command to run the application
CMD ["node", "index.js"]
