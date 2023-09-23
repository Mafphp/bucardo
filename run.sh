#!/bin/bash
# docker compose build 

docker compose run --name bucardo-container --rm -d bucardo \
    -b 'add db ${SOURCE_BUCARDO_DB} dbhost=${SOURCE_HOST} dbname=${SOURCE_DATABASE} dbuser=${SOURCE_USERNAME} dbport=${SOURCE_PORT} dbpass=${SOURCE_PASSWORD}' \
    -b 'add db ${TARGET_BUCARDO_DB} dbhost=${TARGET_HOST} dbname=${TARGET_DATABASE} dbuser=${TARGET_USERNAME} dbport=${TARGET_PORT} dbpass=${TARGET_PASSWORD}' \
    -b 'add relgroup ${BUCARDO_GROUP}' \
    -b 'add all tables db=${SOURCE_BUCARDO_DB} relgroup=${BUCARDO_GROUP}' \
    -b 'add all sequences db=${SOURCE_BUCARDO_DB} relgroup=${BUCARDO_GROUP}' \
    -b 'add sync ${BUCARDO_SYNC_SOURCE_TO_TARGET} dbs=${SOURCE_TO_TARGET_DBS} tables=${SOURCE_TO_TARGET_TABLES} onetimecopy=${SOURCE_TO_TARGET_COPY_MECHANISM}' \
    -b 'activate ${BUCARDO_SYNC_SOURCE_TO_TARGET}'
    # -b 'add sync ${BUCARDO_SYNC_TARGET_TO_SOURCE} dbs=${TARGET_TO_SOURCE_DBS} tables=${TARGET_TO_SOURCE_TABLES} onetimecopy=${TARGET_TO_SOURCE_COPY_MECHANISM}' \
    # -b 'activate ${BUCARDO_SYNC_TARGET_TO_SOURCE}'

# docker compose run --name bucardo-container -t --rm bucardo \
#     -b 'add db workshop dbhost=${SOURCE_HOST} dbname=${SOURCE_DATABASE} dbuser=${SOURCE_USERNAME} dbport=${SOURCE_PORT} dbpass=${SOURCE_PASSWORD}' \
#     -b 'add db arvan dbhost=${TARGET_HOST} dbname=${TARGET_DATABASE} dbuser=${TARGET_USERNAME} dbport=${TARGET_PORT} dbpass=${TARGET_PASSWORD}' \
#     -b 'add sync sarsabad_workshop_db dbs=workshop:source,arvan:source tables=all exclude-table=migrations,seeders onetimecopy=1' \
#     -b 'activate sarsabad_workshop_db'
