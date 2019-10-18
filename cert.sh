#!/bin/bash

#Declare the variable SERVER.

SERVER=$1

#We get the expiration date of the ssl certificate. We translate it into a timestamp, and then we bring it to the format YYYY-MM-DD (e.g. 2019-08-10).

dateNotAfter=$(echo | openssl s_client -connect $SERVER:443 -servername $SERVER -tlsextdebug 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d'=' -f2)
dateNotAfterStamp=$(date +"%s" -d "$dateNotAfter")
dateNotAfterClear=$(date +"%Y-%m-%d" -d "@$dateNotAfterStamp")

#We get the current date in timestamp format, then we convert to the format YYYY-MM-DD (e.g. 2019-10-17).

currentDateStamp=$(date +"%s")
currentDateClear=$(date +"%Y-%m-%d" -d "@$currentDateStamp")

#Count the number of days left. Subtract the current date from the expiration date of the certificate and divide by 86400 (the number of seconds in 24 hours).
#P.S. You can take away the moment with bringing dates to a beautiful format and leave them at the time of bringing them to timestamp.
#Substitute the results as variables in brackets and get the same result. But I like it more.

result=$(( ($(date -d $dateNotAfterClear +%s) - $(date -d $currentDateClear +%s)) / 86400 ))
echo -e "\e[42m $result \e[0m"

# Where applicable:
# - You can receive information in the console and be satisfied with it.
# - can be connected to zabbix. The script will return a number that can already be operated on.
#   For example, configure monitoring to warn that after a certain time the certificate will expire and it is time to start acting.
# - - in any other situations in which your imagination wants to use such data.
