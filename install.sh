#!/bin/bash

#configs
package_id="packages/GeoLite2-Country-ID.csv"
package_ipv4="packages/GeoLite2-Country-Blocks-IPv4.csv"

country="AL\|RS\|ME\|MK"
folder="rules"
file="setting.sh"
counter=0

# check if file exists
if [[ -f $package_ipv4 ]]; else
 echo "download country ipv4 blocks"
 echo "at download.maxmind.com"
 exit 1
fi

mkdir $folder

# loop for country id
while IFS= read -r i; do
 id=$(echo $i | cut -f4 -d, | tr -d '"')
 if [ $id \> 1 ]; then
  echo $id >> _t.emp
 fi
done< <(grep $country $package_ip)

# remove duplicates
while IFS= read -r j; do
 echo $j >> t.emp
done< <(sort _t.emp | uniq)

# get ip from db
while IFS= read -r k; do
 while IFS= read -r l; do
  ld=$(echo $l | cut -f1 -d,)
  echo "sudo iptables -A INPUT -s ${kd} -j ACCEPT" >> $folder/$file
  ((counter++))
 done< <(grep $k $package_ipv4)
done< <(cat t.emp)

# end
rm t.emp
cd $folder
echo "iptables -A INPUT -j DROP" >> $file
echo "loaded ${counter} rules"
echo "execute bash settings.sh"
echo "country ${country}"
