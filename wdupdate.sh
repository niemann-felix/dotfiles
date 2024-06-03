#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

#for i in ~/Documents/github/*
#  do
#    echo "git fetch $i"
#    cd $i
#    git fetch --recurse-submodules &
#    cd ..
#  done

#echo "Waiting for jobs to finish..."
#wait

if [ "$1" = "pull" ]; then
  for i in ~/Documents/github/*
  do
    echo "git pull $i"
    cd $i
    git pull &
    cd ..
  done
  echo "Waiting for jobs to finish..."
  wait
fi

check_git_status() {
  local dir=$1
  local depth=$(($2 * 5))
  if [ $2 -gt 0 ]; then
    local pdir="${dir%/*}"         # Remove the last segment
    local pdir="${pdir##*/}/${dir##*/}"
  else
    local pdir=${dir##*"/"}
  fi

  cd "$dir"
  git fetch --quiet

  output=$(git status)

  if echo "$output" | grep -q "Your branch is ahead"; then
    printf '%*s' "$depth" ''
    printf "${bold}Local ahead of remote \t \t $pdir ${normal}\n"
  elif echo "$output" | grep -q "Your branch is behind"; then
    printf '%*s' "$depth" ''
    printf "${bold}Remote ahead of local \t \t $pdir ${normal}\n"
  elif echo "$output" | grep -q "Untracked files:"; then
    printf '%*s' "$depth" ''
    printf "${bold}Untracked files \t \t $pdir ${normal}\n"
  elif echo "$output" | grep -q "Changes not staged for commit:"; then
    printf '%*s' "$depth" ''
    printf "${bold}Changes not staged for commit \t $pdir ${normal}\n"
  elif echo "$output" | grep -q "Changes to be committed:"; then
    printf '%*s' "$depth" ''
    printf "${bold}Changes to be committed \t $pdir ${normal}\n"
  else
    printf '%*s' "$depth" ''
    printf "OK \t \t \t \t $pdir \n"
  fi

  count=0

  for subdir in "$dir"/*; do
  if [ -d "$subdir" ] && [ -e "$subdir/.git" ]; then
    check_git_status "$subdir" $((depth + 1)) &
    # increment here
    ((count++))
  fi
  done

  wait

  #  if var = 0 here
  # if [ $count -gt 0 ]; then
  #   printf "\n"
  # fi
}

export check_git_status

for repo in ~/Documents/github/*; do
  if [ -d "$repo/.git" ]; then
    check_git_status "$repo" 0 &
  fi
done

wait
