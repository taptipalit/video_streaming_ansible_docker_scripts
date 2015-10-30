#!/bin/bash

videoServerIp="$1"
hostFileName="$2"
remoteOutputPath="$3"
numClientsPerHost="$4"
numSessions="$5"
rate="$6"

if [ $# -ne 5 ]; then
  echo "Usage: launch_hunt_bin.sh <video_server_ip> <host_list_file> <remote_output_path> <num_clients_per_host> <num_sessions> <rate>"
  exit 
fi

logs=$(echo logs/cl* | sed -e 's/ /,/g')

while read hostLine
do
  IFS=':'
  for ip in $hostLine; do

    IFS='-'; declare -a d=($ip)
    host=$d[0]
    ips=$(echo ${d[@]:1:100} | sed -e 's/ /,/g')
    ssh $host "sudo mkdir -m 0777 -p $remoteOutputPath/results"
    echo "Launching clients on $host";
    for i in $(seq 1 $numClientPerHost)
    do
      cmd="./httperf --hog --server $videoServerIp --videosesslog=[$logs],[0.1,0.3,0.4,0.2],[$ips] --epoll --recv-buffer=524288 --port 80 --output-log=$remoteOutputPath/results/result$i.log --num-sessions=$numSessions --rate=$rate"
      echo "Running command $cmd"
      ssh $host "sudo docker exec streaming_client $cmd" > "stdout$i" &
    done 
    wait
    # Copy over the logs
    cmd="scp -r $host:$remoteOutputPath/results/ ./output/"
    echo $cmd
    eval $cmd
    ssh $host "sudo rm $remoteOutputPath/results/*"

  done
done < "$hostFileName"

