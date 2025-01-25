#!/bin/bash

# Exporting environment variables
export BUILD_DIR=/home/ubuntu/builds
export BE_TARGET_DIR=/home/ubuntu/prime-square
export BE_ARCHIVE_DIR=/home/ubuntu/archive
export BACKUP_DIR=/home/ubuntu/prime-square-backup
export SERVICE=PrimeSquare.service
export SFTP_HOST=192.168.56.106
export SFTP_USER=surya
export SFTP_KEY=/var/go/.ssh/id_rsa
export SFTP_UPLOADS_DIR=uploads
export BUILD_FILE="ps_be_1.1.26_idfc_1.1.13-8b07db6-319.zip"
export DB_DIR=/home/ubuntu/database
export DB_SCRIPTS_DIR=/home/ubuntu/prime-square/database-scripts
export DB_USER=psdbadmin
export UI_TARGET_DIR=/var/www/html
export UI_ARCHIVE=/home/ubuntu/ui-archive
export TARGET_HOST=192.168.56.105
export BACKUP_DIR=/home/ubuntu/jar-backup