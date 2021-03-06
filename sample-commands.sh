touch /testdir/testfile-`date "+%H-%M-%S"`.log

#!/bin/bash
BACKUP_DIR=/mnt/testdir-`date "+%H-%M-%S"`
sudo mount -t nfs freebsd:/nfs_data /mnt
sudo mkdir $BACKUP_DIR
sudo mv /testdir/testfile-*.log $BACKUP_DIR/.
sudo ls $BACKUP_DIR
sudo umount /mnt

#!/usr/local/bin/bash
tar -czvf /backups/`date "+%d_%m_%Y-%H:%M:%S"`.tar.gz /nfs_data
rm  -rf /nfs_data/*


# List directory in the loop
watch ls /testdir
gnu-watch -x ls /nfs_data
gnu-watch -x ls /backups


# Github link
https://github.com/aleksandr-oliferuk/rundeck-example-stand
