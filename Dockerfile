FROM ubuntu:19.04 
  ENV TERM=xterm
  
    RUN apt-get update && \


RUN XAMPP_DL_LINK=' \
	https://www.apachefriends.org/es/download.html \
	' \   
 
 RUN chmod 755 xampp-linux-installer.run
 RUN ./xampp-linux-installer.run --mode unattended --unattendedmodeui  minimal 
 
 RUN rm ./xampp-linux-installer.run
 # Enable XAMPP web interface(remove security checks)
 
 RUN /opt/lampp/bin/perl -pi -e s'/Require local/Require all granted/g' /opt/lampp/etc/extra/httpd-xampp.conf

# Enable includes of several configuration files
RUN mkdir /opt/lampp/apache2/conf.d && \
echo "IncludeOptional /opt/lampp/apache2/conf.d/*.conf" >> /opt/lampp/etc/httpd.conf

RUN mkdir /www
RUN ln -s /www /opt/Xampp/htdocs/
RUN ln -sf /opt/Xampp/Xampp /usr/bin/lampp

RUN echo "export PATH=\$PATH:/opt/Xampp/bin/" >> /root/.bashrc
RUN echo "export TERM=xterm" >> /root/.bashrc

EXPOSE 8081 443 3306

ADD init.sh /usr/local/bin/init.sh
RUN chmod 777 /usr/local/bin/init.sh

# Start the init script
ENTRYPOINT ["/usr/local/bin/init.sh"]
