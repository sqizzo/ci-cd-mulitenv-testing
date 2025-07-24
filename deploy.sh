#!/bin/bash

# ========== CONFIG ========== #
SERVER_IMAGE_NAME=evently-server
CLIENT_IMAGE_NAME=evently-client
CONTAINER_SERVER=evently-server-container
CONTAINER_CLIENT=evently-client-container
PORT=5000

echo "🧹 Cleaning old containers..."
docker stop $CONTAINER_SERVER || true
docker rm $CONTAINER_SERVER || true
docker stop $CONTAINER_CLIENT || true
docker rm $CONTAINER_CLIENT || true

echo "🐳 Building server Docker image..."
docker build -t $SERVER_IMAGE_NAME ./server

echo "🐳 Building client Docker image..."
docker build -t $CLIENT_IMAGE_NAME ./client

echo "🚀 Running server container..."
docker run -d \
  --name $CONTAINER_SERVER \
  -p 5000:5000 \
  -e MONGO_URL=${MONGO_URL} \
  -e CLIENT_URL=${CLIENT_URL} \
  -e NODEMAILER_HOST=${NODEMAILER_HOST} \
  -e NODEMAILER_PORT=${NODEMAILER_PORT} \
  -e NODEMAILER_UNAME=${NODEMAILER_UNAME} \
  -e NODEMAILER_PASS=${NODEMAILER_PASS} \
  -e JWT_SECRET=${JWT_SECRET} \
  -e GOOGLE_CLIENTID=${GOOGLE_CLIENTID} \
  -e GOOGLE_CLIENTSECRET=${GOOGLE_CLIENTSECRET} \
  -e CLOUDINARY_CLOUD_NAME=${CLOUDINARY_CLOUD_NAME} \
  -e CLOUDINARY_API_KEY=${CLOUDINARY_API_KEY} \
  -e CLOUDINARY_API_SECRET=${CLOUDINARY_API_SECRET} \
  $SERVER_IMAGE_NAME

echo "🌐 Running client container..."
docker run -d \
  --name $CONTAINER_CLIENT \
  -p 5173:5173 \
  $CLIENT_IMAGE_NAME

echo "✅ Deployment selesai!"
