FROM timescale/timescaledb-ha:pg14.2-ts2.6.0-oss-latest

LABEL Maintainer="Fabrizio Pistagna <fabrizio.pistagna@ingv.it>, Mario Torrisi <mario.torrisi@ingv.it>"

### TSDSYTEM
COPY sql/create_tsdsystem_role.sql /docker-entrypoint-initdb.d/01_create_tsdsystem_role.sql
COPY sql/create_tsdsystem_db.sql /docker-entrypoint-initdb.d/02_create_tsdsystem_db.sql
COPY sql/init_schema.sql /docker-entrypoint-initdb.d/03_init_schema.sql
COPY sql/tsd_main.sql /docker-entrypoint-initdb.d/04_tsd_main.sql
COPY sql/tsd_pnet.sql /docker-entrypoint-initdb.d/05_tsd_pnet.sql
COPY sql/tsd_users.sql /docker-entrypoint-initdb.d/06_tsd_users.sql
COPY sql/public.sql /docker-entrypoint-initdb.d/07_public.sql

### DATAREP
COPY sql/create_datarep_role.sql /docker-entrypoint-initdb.d/08_create_datarep_role.sql
COPY sql/create_datarep_db.sql /docker-entrypoint-initdb.d/09_create_datarep_db.sql
