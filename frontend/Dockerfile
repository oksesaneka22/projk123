# Use the official Node.js 18 image as a parent image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of your app's source code
COPY . .

# Build your Next.js app
RUN npm run build

# Expose the port Next.js runs on
EXPOSE 80

# Set environment variables to listen on port 80 and all network interfaces
ENV PORT 80
ENV HOST 0.0.0.0

# Start the app
CMD ["npm", "start"]
