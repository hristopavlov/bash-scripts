#!/bin/bash

SCRIPT_NAME='move_directory_create_symlink.sh'
USAGE_STRING='usage: '$SCRIPT_NAME' <txt_file> <destination_dir_path>'

# Show usage and exit with status
show_usage_and_exit () {
    echo $USAGE_STRING
    exit 1
}

# ERROR file does not exist
no_file () {
    echo $SCRIPT_NAME': '$1': No such file or directory'
    exit 2
}

# Check syntax
if [ $# -ne 2 ]; then
    show_usage_and_exit
fi

# Check file existence
if [ ! -e "$1" ]; then
    no_file $1
fi

# Get paths
txt_file=$1
destination_path=$2

# Check that destination ends with a slash
[[ $destination_path != */ ]] && destination_path="$destination_path"/

for dir_name in $(cat $txt_file) ; do 
# Move source
mv "$dir_name" "$destination_path"

# Get original path
original_path=$destination_path$(basename $dir_name)

# Create symlink in source dir
ln -s "$original_path" "${dir_name%/}"
done
