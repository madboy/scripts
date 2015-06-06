#!/usr/bin/env bash

# Search all the files in the directory for different combinations
# of words
# When we have matches open vim buffers for all of the matching files

if [ "$1" = "and" ]; then
    shift
    MATCH="$1\|$2"
    RES=`grep -ril "$1" * | xargs grep -li "$2"`
elif [ "$1" = "or" ]; then
    shift
    MATCH="$1\|$2"
    RES=`grep -ril "$MATCH" *`
elif [ "$1" = "match" ]; then
    shift
    RES=`grep -rilw $1 *`
else
    RES=`grep -ril $1 *`
fi

if [ "$RES" = "" ]; then
    echo "Cannot find any matching files"
elif [ -n "$MATCH" ]; then
    vim +/"$MATCH" $RES
else
    vim +/$1 $RES
fi
