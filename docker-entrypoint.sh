#!/bin/bash

set -xe


sed -i "s~AuthName.*~AuthName $AUTH_NAME~" /etc/apache2/sites-available/svn-site.conf
sed -i "s~AuthLDAPURL.*~AuthLDAPURL $AUTH_LDAP_URL~" /etc/apache2/sites-available/svn-site.conf
sed -i "s~AuthLDAPBindDN.*~AuthLDAPBindDN $AUTH_LDAP_BIND_DN~" /etc/apache2/sites-available/svn-site.conf
sed -i "s~AuthLDAPBindPassword.*~AuthLDAPBindPassword $AUTH_LDAP_BIND_PW~" /etc/apache2/sites-available/svn-site.conf

sed -i "s~SSLCertificateFile.*~SSLCertificateFile $HTTPS_CERT~" /etc/apache2/sites-available/svn-site.conf
sed -i "s~SSLCertificateKeyFile.*~SSLCertificateKeyFile $HTTPS_KEY~" /etc/apache2/sites-available/svn-site.conf


exec apache2ctl -D FOREGROUND
