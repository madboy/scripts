#!/usr/bin/env bash

# Search all the files in the directory for differnt combinations
# of words
# When we have matches open vim buffers for all of the matching files

if [ "$1" = "and" ]; then
    shift
    WORD1=$1
    WORD2=$2
    RES=`grep -ril "$WORD1" * | xargs grep -li "$WORD2"`
elif [ "$1" = "or" ]; then
    shift
    WORD1=$1
    WORD2=$2
    RES=`grep -ril "$WORD1\|$WORD2" *`
    MATCH="$WORD1\|$WORD2"
elif [ "$1" = "match" ]; then
    shift
    WORD1=$1
    RES=`grep -rilw $WORD1 *`
else
    WORD1=$1
    RES=`grep -ril $WORD1 *`
fi

if [ "$RES" = "" ]; then
    echo "Cannot find any matching files"
elif [ -n "$MATCH" ]; then
    # echo 'vim +/"$MATCH" $RES'
    vim +/"$MATCH" $RES
else
    # echo 'vim +/$WORD1 $RES'
    vim +/$WORD1 $RES
fi
