#!/bin/bash

# Define target directory
TARGET_DIR=/home/ubuntu/prime-square

# Create the directory if it doesn't exist
mkdir -p $TARGET_DIR

# Copy the JAR file to the target directory
cp HelloWorld.jar $TARGET_DIR

echo "JAR file deployed to $TARGET_DIR"
