#!/bin/sh

# Purpose: an OS classification tool which differentiates between Windows and Linux without performing a port scan.
# Usage: OSenum.sh [host.txt]



# check if a commandline argument was given

if [ $# -ne 1 ]; then
  echo "please supply a file containing IP addresses";
  exit 1;
fi

# check if the commandline argument is a valid file

if [ ! -f $1 ]; then
  echo "$1 is not a valid file";
fi

# for each line in the input file
cat $1 | while read ip; do
  # get the ttl using the ping command
  ttl=`ping -c1 -W1 $ip|grep -oP '(?<=ttl=)\d+'`;
  # determine the OS according to the ttl value
  if [ "$ttl" == "128" ]; then
    echo "$ip is likely running Windows";
  elif [ "$ttl" == "64" ]; then
    echo "$ip is probably running Linux or MacOS";
  elif [ -z "$ttl" ]; then
    echo "$ip is down";
  else
    echo "$ip is probably running an OS different than Windows or Linux, or an outdated OS";
  fi
done
