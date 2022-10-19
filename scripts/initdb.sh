#!/bin/sh

PGPASSWORD=${DB_PASSWORD}
echo "Executing scripts from folder sql_create"

echo "RUN create_datarep_role"
psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_datarep_role.sql
echo "END create_datarep_role"

echo "RUN create_datarep_db"
psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_datarep_db.sql
echo "END create_datarep_db"

echo "RUN create_tsdsystem_role"
psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_tsdsystem_role.sql
echo "END create_tsdsystem_role"

# psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_tsdsystem_db.sql

echo "Executing scripts from folder sql_tsd"
echo "RUN init.sql"
psql -h ${DB_HOST} -U ${DB_USER} < /sql_tsd/init.sql
echo "END init.sql"

echo "RUN tsd_main.sql"
psql -h ${DB_HOST} -U ${DB_USER} -d ${TSD_DB} < /sql_tsd/tsd_main.sql
echo "END tsd_main.sql"

echo "RUN tsd_pnet.sql"
psql -h ${DB_HOST} -U ${DB_USER} -d ${TSD_DB} < /sql_tsd/tsd_pnet.sql
echo "END tsd_pnet.sql"

echo "RUN tsd_users.sql"
psql -h ${DB_HOST} -U ${DB_USER} -d ${TSD_DB} < /sql_tsd/tsd_users.sql
echo "END tsd_users.sql"

echo "RUN public.sql"
psql -h ${DB_HOST} -U ${DB_USER} < /sql_tsd/public.sql
echo "END public.sql"