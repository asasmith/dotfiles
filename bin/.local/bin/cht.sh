#!/usr/bin/env bash

languages=$(echo "golang typescript javascript" | tr " " "\n")
core_utils=$(echo "find xargs sed awk" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "GIMMIE YOUR QUERY: " query

if echo "$languages" | grep -qs $selected; then
    tmux new-window bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
else
    tmux new-window bash -c "curl cht.sh/$selected~$query | less"
fi
