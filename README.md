# Cloud Diff Backup
Backup script to present summary of changes on the local filesystem and sync to configured cloud drives once the user approves.

![Screenshot](screenshot.png)

## Project Goal.
A fast bash-based locally generated summary of changes on your local file-system since the last backup.

### Use Case
I looked into several cloud-based command line backup utilities, but I didn't like any of them for my purposes. What I want is a one way rclone sync from a local directory to a remote for multiple remotes. I have a JBOD drive array (using MergerFS,) and I want to ensure that the rclone sync does not remove files from the cloud drive if one of the drives in the JBOD fails to mount.
This script provides quick summary of changes on the local filesystem so the user can perform a sanity check and run the backup script if everyting looks good.

## Supports
- creates directories if needed
- user customizable directories
- generates list of files and shows changes
- automatically cleans up old files
