#!/usr/bin/env bash

# Search all the files in the directory for different combinations
# of words
# When we have matches open vim buffers for all of the matching files

regular_grep() {
    # recursive search, ignore case, only get one line per file
    # ignore binary
    FLAGS="-rilI"

    if [ "$1" = "and" ]; then
        shift
        MATCH="$1\|$2"
        RES=`grep $FLAGS "$1" * | xargs grep -li "$2"`
    elif [ "$1" = "or" ]; then
        shift
        MATCH="$1\|$2"
        RES=`grep $FLAGS "$MATCH" *`
    elif [ "$1" = "match" ]; then
        shift
        RES=`grep $FLAGS -w $1 *`
    else
        RES=`grep $FLAGS $1 *`
    fi

    # open vim with matching files
    if [ "$RES" = "" ]; then
        echo "Cannot find any matching files"
    elif [ -n "$MATCH" ]; then
        vim +/"$MATCH" $RES
    else
        vim +/$1 $RES
    fi
}

git_grep() {
    git grep -Ovi -iI $1
}

# Do we have a directory as last argument
a=("$@")
LAST=${a[-1]}
if [ -d "$LAST" ]; then
    pushd $LAST
fi

# prefer git grep if we can
if [ -d .git/ ]; then
    git_grep $@
else
    regular_grep $@
fi

if [ -d "$LAST" ]; then
    popd
fi
