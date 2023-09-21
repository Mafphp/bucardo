#!/bin/bash
# set -Eeuxo pipefail

docker compose build 

docker compose run --rm bucardo \
    -b 'add db workshop dbhost=192.168.1.102 dbname=sarsabad_workshop_db dbuser=postgres dbport=5003 dbpass=password1' \
    -b 'add db arvan dbhost=192.168.1.102 dbname=sarsabad_arvan_db dbuser=postgres dbport=7003 dbpass=password2' \
    -b 'add relgroup sarsabadgroup' \
    -b 'add all tables db=arvan relgroup=sarsabadgroup' \
    -b 'add all sequences db=arvan relgroup=sarsabadgroup' \
    -b 'add sync workshop_to_arvan dbs=workshop:source,arvan:target tables=employee onetimecopy=0' \
    -b 'activate workshop_to_arvan' 
    # -b 'add sync arvan_to_workshop dbs=arvan,workshop relgroup=sarsabadgroup onetimecopy=1' \
    # -b 'activate arvan_to_workshop'






# docker compose run --rm bucardo \
    # -p 'pg1:5432:*:postgres:test' \
    # -m 'pg1:test4' \
    # -c 'pg1:test>pg1:test4' \
    # -b 'add db test dbhost=pg1 dbname=test dbuser=postgres' \
    # -b 'add db test4 dbhost=pg1 dbname=test4 dbuser=postgres' \
    # -b 'add db test5 dbhost=pg2 dbname=test dbuser=postgres dbpass=test dbport=5432' \
    # -b 'add db db1 dbhost=192.168.1.102 dbname=test dbuser=postgres dbpass=postgres dbport=54333' \
    # -b 'add relgroup testgroup' \
    # -b 'add all tables db=test relgroup=testgroup' \
    # -b 'add all sequences db=test relgroup=testgroup' \
    # -b 'add sync testsync dbs=test,test4 relgroup=testgroup onetimecopy=1' \
    # -b 'add sync test4sync dbs=test4,test relgroup=testgroup onetimecopy=1' \
    # -b 'add sync test5_to_test_sync dbs=test5,test relgroup=testgroup onetimecopy=1' \
    # -b 'add sync test_to_test5_sync dbs=test,test5 relgroup=testgroup onetimecopy=1' \
    # -b 'add sync db1sync dbs=test,db1 relgroup=testgroup onetimecopy=1' \
    # -b 'activate testsync' \
    # -b 'activate test4sync' \
    # -b 'activate db1sync' \
    # -b 'activate test5_to_test_sync' \
    # -b 'activate test5_to_test_sync'

#docker stop bucardo_pg1_1
#docker rm bucardo_pg1_1
# bucardo add db db1_test dbhost=192.168.1.102 dbname=test dbuser=postgres dbpass=postgres dbport=54333
# bucardo add sync db1sync dbs=test,db1_test relgroup=testgroup onetimecopy=1