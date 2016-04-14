#!/bin/bash

# Script arguments:
# $1: image tag
# $2: number of container to run
# $3: cpu share
# Example: ./multi-container.sh <mybimage> 2 <cpushare>

warn () {
    echo "$@" >&2
}

die () {
    status="$1"
    shift
    warn "$@"
    exit "$status"
}

go(){
    for (( i=1; i<=$NBR; i=i+1 ))
    do
        echo -e "\nContainer $CNAMES $i\n"
        IS_CTN="$(sudo docker ps -a | grep $CNAMES$i | awk '{ print $1; }')"
        sudo docker run -tid $CPU1 $CPU2 $CPU3 --hostname $CNAMES$i --name $CNAMES$i $ITAG 
        sleep 2
    done
}


if [ "$#" -lt 2 ] && [ "$#" -gt 3 ]; then
  echo ""
  echo -e "Usage: $0 <image-tag> <nbr-of-containers> <cpu-options>\n" >&2
  echo Example of cpu option: -c 50000
  echo ""
  die 1
fi

ITAG="$(sudo docker images | grep $1 | awk '{ print $3; }')"
IS_IMAGE="$(sudo docker images | grep $1 | awk '{ print $1; }')"
CNAMES="test-container"
NBR=$2
CPU1=$3
CPU2=$4
CPU3=$5
echo "Image tag = $1"
echo "Number of containers = $2"
echo "ITAG = $ITAG"
echo "IS_IMAGE = $IS_IMAGE"



if [ "$IS_IMAGE" == "" ]
then
  echo -e "Image $1 not found \n" >&2
  echo -e "Check for the available image with <docker images> command. \n"
  docker pull $1
fi
go

