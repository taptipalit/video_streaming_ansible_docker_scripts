#!/bin/bash

dev=$1

N=0
IFS=':'
for ip in $2; do
  IFS='-'; declare -a d=($ip)
  ip addr add ${d[0]}/24 dev $dev

  N=$[$N+1]
  ipfw delete 100$N
  ipfw add 100$N pipe $N ip from ${d[0]} to any out
  ipfw pipe $N config buckets 65535 bw ${d[1]}Mbit/s queue ${d[1]}Mbit/s mask all

  N=$[$N+1]
  ipfw delete 100$N
  ipfw add 100$N pipe $N ip from any to ${d[0]} in
  ipfw pipe $N config buckets 65535 bw ${d[1]}Mbit/s queue ${d[1]}Mbit/s mask all
done
