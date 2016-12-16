#!/usr/bin/bash
days=8
pool=data/backups/mail
#date=`date +%u`
if ps -ef | grep -i mailtest:/var/spool/mail/test.com | grep -qv grep
then echo "rsync is already running,exit..." 
     exit
else rsync -av --delete mailtest:/var/spool/mail/test.com /data/backups/mail/
#     if zfs list | grep mail | grep day7
#     then zfs destroy data/backups/mail@day$date && zfs snapshot data/backups/mail@day$date
#     else zfs snapshot data/backups/mail@day$date
zfs snapshot $pool@$(date +%Y%m%d)

zfs list -t snapshot -o name | grep $pool | sort -r |tail -n +$days | xargs -n 1 zfs destroy
fi
