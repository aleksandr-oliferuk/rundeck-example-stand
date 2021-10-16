touch /tmp/testdir/testfile-`date "+%H-%M-%S"`.log

#!/bin/bash
BACKUP_DIR=/mnt/testdir-`date "+%H-%M-%S"`
sudo mount -t nfs freebsd:/nfs_data /mnt
sudo mkdir $BACKUP_DIR
sudo mv /tmp/testdir/* $BACKUP_DIR/.
sudo ls $BACKUP_DIR
sudo umount /mnt

rm -rf /nfs_data/*
