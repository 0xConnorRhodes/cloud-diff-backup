#!/bin/bash

# I also want to know how many files vs last time and sort old and new files

# directories. Change this to whatever you want
CACHEDIR=$HOME/.cache/rclone-backup-script
BACKUPDIR=/mnt/pool/rclonesync
REMOTE1=gdrive_unlimited_crypt:/
REMOTE2=opencrypt:/

# if the cache directories do not already exit, create them
[[ -d $CACHEDIR ]] || mkdir "$CACHEDIR"
[[ -d $CACHEDIR/file-lists ]] || mkdir "$CACHEDIR/file-lists"
[[ -d $CACHEDIR/diffs ]] || mkdir "$CACHEDIR/diffs"

# make a new list
find $BACKUPDIR | sort -n > $CACHEDIR/file-lists/$(date +"%Y-%m-%d_%H-%M-%S").txt

# remove all but the two most recent files from the file-list cache
cd $CACHEDIR/file-lists
ls -t | tail -n +3 | xargs rm --
# remove all but the seven oldest diffs from the diffs cache
cd $CACHEDIR/diffs
ls -t | tail -n +8 | xargs rm --

# show diff of older file -> newerfile
# note that ">" is a new file and "<" is a removed file
cd $CACHEDIR/file-lists
read OLDFILE < <(ls -rt *.txt)
read NEWFILE < <(ls -t *.txt)
diff $OLDFILE $NEWFILE | sed -nr '/<|>/p' > $CACHEDIR/diffs/$(date +"%Y-%m-%d_%H-%M-%S").diff
cd $CACHEDIR/diffs
less $(ls -1rt | tail -n 1)

PS3='Please enter your choice: '
options=("Run sync" "Show diff again" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Run sync")

    		#print what is happening with a 30 second timer
    		tsecs=30
    		while [ $tsecs -gt 0 ]
    		do
    		    printf "\r\033[KSyncing $REMOTE1 and then $REMOTE2 in %.d seconds" $((tsecs--))
    		    sleep 1
    		done

	    #rclone sync -P $BACKUPDIR $REMOTE1
	    #rclone sync -P $BACKUPDIR $REMOTE2
	    ping google.com -c 4
	    ping cisco.com -c 4
	    break
            ;;
        "Show diff again")
            cd $CACHEDIR/diffs
	    less $(ls -1rt | tail -n 1)
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
