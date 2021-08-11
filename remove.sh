#!/bin/bash

echo $1     #filter file
echo $2     #bins dir
eCollection=( $(cut -d ',' -f2 $1 ) )     

extension=".fa"
declare -i len=${#eCollection[@]}

declare -i sub=1

declare -i num_of_lines=$(< "$1" wc -l)


cd $2       

i=2
while [ "$i" -le "$num_of_lines" ]; do
  total="${eCollection[$i]}$extension"
  printf "%s\n" $total
  rm $total
  i=$(($i + 1))
done
cd ..