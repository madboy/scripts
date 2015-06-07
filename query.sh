#!/usr/bin/env bash
# set -ex

# Search all the files in the directory for different combinations
# of words
# When we have matches open vim buffers for all of the matching files

no_editor="false"

regular_grep() {
    # recursive search, ignore case, only get one line per file
    # ignore binary
    FLAGS="-riIn"

    if [ "$1" = "and" ]; then
        shift
        MATCH="$1\|$2"
        if [ "$no_editor" = "true" ]; then
            grep $FLAGS "$1" * | xargs grep -i "$2"
        else
            RES=`grep $FLAGS -l "$1" * | xargs grep -li "$2"`
        fi
    elif [ "$1" = "or" ]; then
        shift
        MATCH="$1\|$2"
        if [ "$no_editor" = "true" ]; then
            grep $FLAGS "$MATCH" *
        else
            RES=`grep $FLAGS -l "$MATCH" *`
        fi
    elif [ "$1" = "match" ]; then
        shift
        if [ "$no_editor" = "true" ]; then
            grep $FLAGS -w $1 *
        else
            RES=`grep $FLAGS -l -w $1 *`
        fi
    else
        if [ "$no_editor" = "true" ]; then
            grep $FLAGS $1 *
        else
            RES=`grep $FLAGS -l $1 *`
        fi
    fi

    if [ "$no_editor" = "false" ]; then
        # open vim with matching files
        if [ "$RES" = "" ]; then
            echo "Cannot find any matching files"
        elif [ -n "$MATCH" ]; then
            vim +/"$MATCH" $RES
        else
            vim +/$1 $RES
        fi
    fi
}

git_grep() {
    if [ "$no_editor" = true ]; then
        FLAGS="-niI"
    else
        FLAGS="-Ovi -iI"
    fi

    # this and behaves differently from the regular grep
    # only matches on the same line instead of in the same file
    if [ "$1" = "and" ]; then
        shift
        git grep $FLAGS -e "$1" --and -e "$2"
    elif [ "$1" = "or" ]; then
        shift
        git grep $FLAGS -e "$1" --or -e "$2"
    elif [ "$1" = "match" ]; then
        shift
        git grep $FLAGS -w $1
    else
        git grep $FLAGS $1
    fi
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
