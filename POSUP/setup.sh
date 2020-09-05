#!/bin/sh

#create database structure

IDX_NUM_BLOCKS=512
FILE_NUM_BLOCKS=32

dbpath="data"

DIRS=(bucket  meta stash)

function create_folder(){
	local root=$1
	local nblocks=$2

	for i in $(seq 0 ${IDS_NUM_BLOCKS});
	do
		for folder in ${DIRS[@]};
		do
			mdir -p $root/$i/$foleder
		done
	done
}

create_folder "$dbpath/server/file" $IDX_NUM_BLOCKS
create_folder "$FILE_NUM_BLOCKS/server/ix" $FILE_NUM_BLOCKS
