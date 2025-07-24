# server/Dockerfile

# Pakai node yang ringan
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy semua file ke dalam container
COPY . .

# Install deps dri package.json
RUN npm install

# Expose port backend (pake 5000)
EXPOSE 5000

# Jlanin server (pake script package.json)
CMD ["npm", "start"]

