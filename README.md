# sslCertificateExpiration
Author: <b>Vladimir Prisyazhnikov (Chuck Tornton)</b><br>
Current version: <b>0.1.0</b>

This script allows you to get the number of days before the expiration of the certificate or the number of days in percent.

#### Where applicable:
 - You can receive information in the console and be satisfied with it.
 - can be connected to zabbix. The script will return a number that can already be operated on.
For example, configure monitoring to warn that after a certain time the certificate will expire and it is time to start acting.
 - in any other situations in which your imagination wants to use such data.



#### For Alpine Linux:

Please install:

- Select your timezone.
- apk add --update && apk add coreutils

#### For Ubuntu:

- Select your timezone.
- Working works out of the box.

### How to use:

- Make the file executable:<br>
  chmod +x cert.sh
- Run the command:<br>
 <b>./cert.sh google.com </b>  or  <b> ./cert.sh google.com day </b><br>
to get the number of days left

- Run the command: <br>
 <b>./cert.sh google.com percent</b> <br>
to get the amount of remaining interest, where 100% =
full validity of the certificate.

#### If you want to use the script in Zabbix:

- Copy in <b>cert.sh</b> to the <b>/etc/zabbix/externalscripts/</b>
- Make the copied file executable: <b>chmod +x cert.sh</b>
- Make Zabbix the owner of the file: <b> chown zabbix cert.sh </b>
