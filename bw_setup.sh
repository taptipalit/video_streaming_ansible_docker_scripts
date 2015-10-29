if=$1
ip_alias1=$2
ip_alias2=$3
ip_alias3=$4
ip_alias4=$5

ifconfig $if:0 $ip_alias1 netmask 255.255.255.0
ifconfig $if:1 $ip_alias2 netmask 255.255.255.0
ifconfig $if:2 $ip_alias3 netmask 255.255.255.0
ifconfig $if:3 $ip_alias4 netmask 255.255.255.0


ipfw add pipe 1 ip from $ip_alias1 to any out
ipfw add pipe 2 ip from any to $ip_alias1 in
ipfw pipe 1 config buckets 65535 bw 15Mbit/s queue 15Mbit/s mask all
ipfw pipe 2 config buckets 65535 bw 15Mbit/s queue 15Mbit/s mask all

ipfw add pipe 3 ip from $ip_alias2 to any out
ipfw add pipe 4 ip from any to $ip_alias2 in
ipfw pipe 3 config buckets 65535 bw 12Mbit/s queue 12Mbit/s mask all
ipfw pipe 4 config buckets 65535 bw 12Mbit/s queue 12Mbit/s mask all

ipfw add pipe 5 ip from $ip_alias3 to any out
ipfw add pipe 6 ip from any to $ip_alias3 in
ipfw pipe 5 config buckets 65535 bw 7Mbit/s queue 7Mbit/s mask all
ipfw pipe 6 config buckets 65535 bw 7Mbit/s queue 7Mbit/s mask all

ipfw add pipe 7 ip from $ip_alias4 to any out
ipfw add pipe 8 ip from any to $ip_alias4 in
ipfw pipe 7 config buckets 65535 bw 4Mbit/s queue 4Mbit/s mask all
ipfw pipe 8 config buckets 65535 bw 4Mbit/s queue 4Mbit/s mask all
