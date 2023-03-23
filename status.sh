#!/bin/bash
#set -o xtrace

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

gitStatusThis() {
    if [ -d "$1" ]; then
        pushd $1
        branch=`git rev-parse --abbrev-ref HEAD`
        changes=`git status -suno | wc -l`
        printf "%-30s | %-7s | %-30s\n" "$1" "$changes" "$branch"
        popd
    fi
}

showRepoStatus() {
    echo "Displaying the state of current repositories..."
    echo
    printf "%-30s | %-7s | %-30s\n" "REPOSITORY" "CHANGES" "BRANCH" 
    for d in *; do
        gitStatusThis $d &
    done
    
    wait
    echo
}

#clear
showRepoStatus
