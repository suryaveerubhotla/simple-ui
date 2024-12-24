#!/bin/bash

# Ensure the target directory exists
mkdir -p /home/ubuntu/prime-square

# Copy the JAR file from the workspace to the target directory
cp HelloWorld.jar /home/ubuntu/prime-square/

# Set permissions on the JAR file (optional but recommended)
chmod 755 /home/ubuntu/prime-square/HelloWorld.jar

# Output a success message
echo "JAR file has been deployed to /home/ubuntu/prime-square"
