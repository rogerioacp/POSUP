#!/usr/bin/env bash
#set -v
#set -x
#create database structure

IDX_NUM_BLOCKS=7
FILE_NUM_BLOCKS=11

DB_PATH="data"

FOLDERS=(bucket meta stash)


function create_server {
	local root=$1
	local nblocks=$2

	for i in $(seq 0 ${nblocks});
	do
		for folder in ${FOLDERS[@]};
		do
			#echo $root/$i/$folder
			mkdir -p $root/$i/$folder
		done
	done
}

create_server "$DB_PATH/server/file" $FILE_NUM_BLOCKS
create_server "$DB_PATH/server/idx" $IDX_NUM_BLOCKS

mkdir -p "$DB_PATH/fileBlock"
mkdir -p "$DB_PATH/idxBlock"
mkdir -p "$DB_PATH/client"
