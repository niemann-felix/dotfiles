bold=$(tput bold)
normal=$(tput sgr0)

for i in ~/Documents/github/*
  do
    echo "git fetch $i"
    cd $i
    git fetch &
    cd ..
  done

echo "Waiting for jobs to finish..."
wait

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

for i in ~/Documents/github/*
do
  cd $i
  output=$(git status)
  if echo $output | grep -q "Your branch is ahead"; then
    printf "${bold}Local ahead of remote \t \t $i ${normal}\n"
  elif echo $output | grep -q "Your branch is behind"; then
    printf "${bold}Remote ahead of local \t \t $i ${normal}\n"
  elif echo $output | grep -q "Untracked files:"; then
    printf "${bold}Untracked files \t \t $i ${normal}\n"
  elif echo $output | grep -q "Changes not staged for commit:"; then
    printf "${bold}Changes not staged for commit \t $i ${normal}\n"
  elif echo $output | grep -q "Changes to be committed:"; then
    printf "${bold}Changes to be committed \t $i ${normal}\n"

  else
    printf "OK \t \t \t \t $i \n"
  fi
  cd ..
done
