#!/bin/bash
#set -o xtrace

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

showRepoStatus() {
    echo "Displaying the state of current repositories..."
    echo
    printf "%-30s | %-7s | %-30s\n" "REPOSITORY" "CHANGES" "BRANCH" 
    for d in *; do
        if [ -d "$d" ]; then
            pushd $d
            branch=`git rev-parse --abbrev-ref HEAD`
            changes=`git status -suno | wc -l`
            printf "%-30s | %-7s | %-30s\n" "$d" "$changes" "$branch"
            popd
        fi
    done
    
    echo
}

#clear
showRepoStatus