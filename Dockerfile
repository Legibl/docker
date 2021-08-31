FROM debian 
FROM debian

COPY debian.list /home/kali/OS/devops/docker/lab1/sources.list.d/

RUN 	apt-get update && \
        apt-get install -y procps && \
	apt-get -y upgrade && \
	apt-get -y install nginx && \
	apt-get clean && \
	rm -rf /var/www/* && \
	mkdir -p /var/www/company.com/img
	
COPY index.html /var/www/company.com/
COPY img.jpg /var/www/company.com/img
RUN	chmod -R 754 var/www/company.com && \
	 useradd stas && \
    groupadd burlak  && \
    usermod -aG burlak stas && \
    chown -R stas:burlak /var/www/company.com && \
    sed -i 's/\/var\/www\/html/\/var\/www\/company.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user stas/g' /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
