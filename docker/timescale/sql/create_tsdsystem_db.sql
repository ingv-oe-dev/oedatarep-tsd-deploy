-- Database: TSD_DB

-- DROP DATABASE TSD_DB;

CREATE DATABASE "TSD_DB"
    WITH 
    OWNER = "TSD_DB_USER"
    ENCODING = 'UTF8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

\connect TSD_DB;

ALTER DEFAULT PRIVILEGES
GRANT ALL ON TABLES TO "TSD_DB_USER" WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES
GRANT ALL ON SEQUENCES TO "TSD_DB_USER" WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES
GRANT EXECUTE ON FUNCTIONS TO "TSD_DB_USER" WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES
GRANT EXECUTE ON FUNCTIONS TO PUBLIC;

ALTER DEFAULT PRIVILEGES
GRANT USAGE ON TYPES TO "TSD_DB_USER";

ALTER DEFAULT PRIVILEGES
GRANT USAGE ON TYPES TO PUBLIC;
