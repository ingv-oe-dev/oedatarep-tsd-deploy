#!/bin/sh

PGPASSWORD=${DB_PASSWORD}
echo "Executing scripts from folder sql_create"

echo "RUN create_datarep_role"
sed -i "s/\bDATAREP_DB_USER\b/$DATAREP_DB_USER/g" /sql_create/create_datarep_role.sql
sed -i "s/\bDATAREP_DB_PASSWORD\b/$DATAREP_DB_PASSWORD/g" /sql_create/create_datarep_role.sql
psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_datarep_role.sql
echo "END create_datarep_role"

echo "RUN create_datarep_db"
sed -i "s/\bDATAREP_DB\b/$DATAREP_DB/g" /sql_create/create_datarep_db.sql
sed -i "s/\bDATAREP_DB_USER\b/$DATAREP_DB_USER/g" /sql_create/create_datarep_db.sql
psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_datarep_db.sql
echo "END create_datarep_db"

echo "RUN create_tsdsystem_role"
sed -i "s/\bTSD_DB_USER\b/$TSD_DB_USER/g" /sql_create/create_tsdsystem_role.sql
sed -i "s/\bTSD_DB_PASSWORD\b/$TSD_DB_PASSWORD/g" /sql_create/create_tsdsystem_role.sql
psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_tsdsystem_role.sql
echo "END create_tsdsystem_role"

# psql -h ${DB_HOST} -U ${DB_USER} < /sql_create/create_tsdsystem_db.sql

echo "Executing scripts from folder sql_tsd"
echo "RUN init.sql"
sed -i "s/CREATE DATABASE .*/CREATE DATABASE $TSD_DB/g" /sql_tsd/init.sql
sed -i "s/connect .*/connect $TSD_DB/g" /sql_tsd/init.sql
sed -i "s/\btsdsystem\b/$TSD_DB_USER/g" /sql_tsd/init.sql
psql -h ${DB_HOST} -U ${DB_USER} < /sql_tsd/init.sql
echo "END init.sql"

# Set TSD User password
PGPASSWORD=${TSD_DB_PASSWORD}

echo "RUN tsd_main.sql"
psql -h ${DB_HOST} -U ${TSD_DB_USER} -d ${TSD_DB} < /sql_tsd/tsd_main.sql
echo "END tsd_main.sql"

echo "RUN tsd_pnet.sql"
psql -h ${DB_HOST} -U ${TSD_DB_USER} -d ${TSD_DB} < /sql_tsd/tsd_pnet.sql
echo "END tsd_pnet.sql"

echo "RUN tsd_users.sql"
psql -h ${DB_HOST} -U ${TSD_DB_USER} -d ${TSD_DB} < /sql_tsd/tsd_users.sql
echo "END tsd_users.sql"

echo "RUN public.sql"
psql -h ${DB_HOST} -U ${TSD_DB_USER} -d ${TSD_DB}  < /sql_tsd/public.sql
echo "END public.sql"
