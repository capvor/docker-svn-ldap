FROM debian:buster


ENV AUTH_NAME '"Auth Name"'
ENV AUTH_LDAP_URL '"ldap://host/ou=Users,dc=my-domain,dc=com?uid"'
ENV AUTH_LDAP_BIND_DN '"cn=Manager,dc=my-domain,dc=com"'
ENV AUTH_LDAP_BIND_PW '"secret"'

ENV HTTPS_CERT "/etc/ssl/certs/ssl-cert-snakeoil.pem"
ENV HTTPS_KEY  "/etc/ssl/private/ssl-cert-snakeoil.key"


ARG DEBIAN_FRONTEND=noninteractive

# https://linuxize.com/post/how-to-install-apache-on-debian-10/
# https://www.linode.com/docs/security/ssl/ssl-apache2-debian-ubuntu/
# https://www.linode.com/docs/security/ssl/create-a-self-signed-tls-certificate/
# https://www.linode.com/docs/websites/hosting-a-website-ubuntu-18-04/

# RUN \
#     sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
#     sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

RUN \
    apt-get -q -y update && \
    apt-get install -q -y procps vim-tiny && \
    apt-get install -q -y subversion apache2 libapache2-mod-svn

COPY svn-site.conf /etc/apache2/sites-available/
COPY docker-entrypoint.sh /

RUN \
    chown root:root /etc/apache2/sites-available/svn-site.conf && \
    chmod 644 /etc/apache2/sites-available/svn-site.conf && \
    chown root:root /docker-entrypoint.sh && \
    chmod 744 /docker-entrypoint.sh && \
    a2enmod ssl && a2enmod authnz_ldap && \
    a2dissite *default && \
    a2ensite svn-site.conf && \
    echo '<html><body><a href="/svn/">SVN Repository</a></body></html>' > /var/www/html/index.html && \
    mkdir /var/svn && \
    chown www-data:www-data /var/svn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 443
VOLUME ["/var/svn"]
WORKDIR /var/svn

ENTRYPOINT ["/docker-entrypoint.sh"]
