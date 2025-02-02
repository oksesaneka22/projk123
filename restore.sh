#!/bin/bash

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="password"
MYSQL_CONTAINER="site123-mysql-1"  # Name of the MySQL container
MYSQL_DB="todo_db"

# S3 Bucket
S3_BUCKET="s3://backeups-site123/backups"

# List available backups in the S3 bucket
echo "Listing available backups in S3..."
aws s3 ls $S3_BUCKET/ --recursive

# Prompt for the backup filename to restore
echo "Enter the backup filename to restore (e.g., todo_db_2025-02-02_14-44-30.sql):"
read BACKUP_FILE

# Check if the backup file exists in the S3 bucket
echo "Checking if $BACKUP_FILE exists in S3..."
aws s3 ls $S3_BUCKET/$BACKUP_FILE > /dev/null

if [ $? -ne 0 ]; then
    echo "Backup file $BACKUP_FILE not found in S3."
    exit 1
fi

# Temporary file to store the backup
TEMP_BACKUP_FILE="/tmp/${BACKUP_FILE}"

# Download the backup file from S3
echo "Downloading backup from S3..."
aws s3 cp $S3_BUCKET/$BACKUP_FILE $TEMP_BACKUP_FILE

# Check if the backup file was downloaded successfully
if [ ! -f $TEMP_BACKUP_FILE ]; then
    echo "Failed to download backup from S3."
    exit 1
fi

# Restore the database inside the MySQL container
echo "Restoring MySQL database..."
docker exec -i $MYSQL_CONTAINER mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB < $TEMP_BACKUP_FILE

# Check if the restore was successful
if [ $? -eq 0 ]; then
    echo "Database restoration completed successfully."
else
    echo "Database restoration failed."
    exit 1
fi

# Optionally, clean up the backup file after restoration
# rm $TEMP_BACKUP_FILE
# echo "Backup file deleted."

echo "Restore completed!"
