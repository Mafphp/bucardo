FROM postgres:14

RUN apt-get update 
RUN BUCARDO_VERSION=5.5.0 DBIXSAFE_VERSION=1.2.5 && apt-get install -yy postgresql-plperl-14 libdbi-perl libdbd-pg-perl curl make && apt-get clean 

RUN mkdir /files
COPY ./Bucardo-5.5.0.tar.gz /files
COPY ./DBIx-Safe-1.2.5.tar.gz /files

RUN mkdir -p /bucardo /dbixsafe 
RUN tar xvf /files/Bucardo-5.5.0.tar.gz -C /bucardo --strip-components=1
RUN tar xvf /files/DBIx-Safe-1.2.5.tar.gz -C /dbixsafe --strip-components=1
RUN cd /dbixsafe && perl Makefile.PL && make install
RUN cd /bucardo && perl Makefile.PL && make install
RUN rm -rf /bucardo /dbixsafe /docker-entrypoint.sh /docker-entrypoint-initdb.d

COPY fs/ /

# CMD ["sleep", "infinity"]
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]