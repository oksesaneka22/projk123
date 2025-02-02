#!/bin/bash

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="password"
MYSQL_CONTAINER="site123-mysql-1"  # Name of the MySQL container
MYSQL_DB="todo_db"

# Backup directory
BACKUP_DIR="/tmp/backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${BACKUP_DIR}/todo_db_${DATE}.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create backup inside the MySQL container
echo "Backing up MySQL database..."
docker exec $MYSQL_CONTAINER mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB > $BACKUP_FILE

# Check if the backup file is empty
if [ ! -s $BACKUP_FILE ]; then
    echo "Backup failed or is empty."
    exit 1
fi

# S3 Bucket
S3_BUCKET="s3://backeups-site123/backups"

# Upload to S3
echo "Uploading backup to S3..."
aws s3 cp $BACKUP_FILE $S3_BUCKET/

# Optionally, you can delete the local backup after upload
# rm $BACKUP_FILE

echo "Backup completed!"
