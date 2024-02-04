#!/bin/bash
echo "Checking Repository"
DIR='./fullsave'

# Read the first line from GIT_CRED.txt and assign it to the variable 'KEY'
KEY=$(head -n 1 GIT_CRED.txt)
REP="https://${KEY}@github.com/niemann-felix/fullsave.git"

if [ -d "$DIR" ]; then
  ### Take action if $DIR exists ###
  echo "Pulling Repository"
  cd $DIR
  git pull
  cd ..
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Cloning Repository"
  git clone $REP
  exit 0
fi

echo "Calling python3 ./fullsave/fullsave.py ALL"
python3 ./fullsave/fullsave.py ALL
