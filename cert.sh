#!/bin/bash

#Author: Vladimir Prisyazhnikov (Chuck Tornton)

SERVER=$1
UNIT=$2

dateNotBefore=$(echo | openssl s_client -connect $SERVER:443 -servername $SERVER -tlsextdebug 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notBefore | cut -d'=' -f2)
dateNotBeforeStamp=$(date +"%s" -d "$dateNotBefore")
dateNotBeforeClear=$(date +"%Y-%m-%d" -d "@$dateNotBeforeStamp")

dateNotAfter=$(echo | openssl s_client -connect $SERVER:443 -servername $SERVER -tlsextdebug 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d'=' -f2)
dateNotAfterStamp=$(date +"%s" -d "$dateNotAfter")
dateNotAfterClear=$(date +"%Y-%m-%d" -d "@$dateNotAfterStamp")

currentDateStamp=$(date +"%s")
currentDateClear=$(date +"%Y-%m-%d" -d "@$currentDateStamp")

results=$(( ($(date -d $dateNotAfterClear +%s) - $(date -d $dateNotBeforeClear +%s)) / 86400 ))

day=$(( ($(date -d $dateNotAfterClear +%s) - $(date -d $currentDateClear +%s)) / 86400 ))

if [[ "$UNIT" == "percent" ]]; then
    let "percent = ($day * 100) / $results"
    echo $percent
else
    echo $day
fi