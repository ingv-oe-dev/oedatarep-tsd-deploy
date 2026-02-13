#!/bin/sh

# init db and create tables
/usr/local/bin/invenio db init
/usr/local/bin/invenio db create

# create admin role for admin user
/usr/local/bin/invenio roles create admin
/usr/local/bin/invenio users create --password ${IRDM_ADMIN_PASSWORD} --active ${IRDM_ADMIN_USER}
/usr/local/bin/invenio roles add ${IRDM_ADMIN_USER} admin
/usr/local/bin/invenio access allow superuser-access role admin

/usr/local/bin/invenio files location create datalocation file:///opt/invenio/var/instance/data --default

# recreate indices
#invenio index destroy --yes-i-know
/usr/local/bin/invenio index init

# reindex records
/usr/local/bin/invenio rdm-record#!/bin/sh
set -e # Esce in caso di errore

echo "==> Starting InvenioRDM initialization..."

# 1. Attendiamo che il DB sia raggiungibile
echo "Check database connection ($DATAREP_DB)..."
until pg_isready -h db -U ${DATAREP_DB_USER}; do
  echo "Database not ready... wait 2 secs."
  sleep 2
done

# 2. Controllo se il database è già stato inizializzato
# Verifichiamo se esiste la tabella 'alembic_version', tipica di un DB Invenio pronto.
TABLE_EXISTS=$(psql -h db -U ${DATAREP_DB_USER} -d ${DATAREP_DB} -tAc "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'alembic_version');")

if [ "$TABLE_EXISTS" = "f" ]; then
    echo "Database is empty. Proceed with initialization..."
    
    # Init db and create tables
    /usr/local/bin/invenio db init
    /usr/local/bin/invenio db create

    # create admin role for admin user
    /usr/local/bin/invenio roles create admin
    /usr/local/bin/invenio users create --password ${IRDM_ADMIN_PASSWORD} --active ${IRDM_ADMIN_USER}
    /usr/local/bin/invenio roles add ${IRDM_ADMIN_USER} admin
    /usr/local/bin/invenio access allow superuser-access role admin

    /usr/local/bin/invenio files location create datalocation file:///opt/invenio/var/instance/data --default
    
    echo "Database initialization completed."
else
    echo "Database already initialized. Skipping creation of users tables."
fi

# 3. Operazioni di indicizzazione (queste possono essere eseguite o saltate a seconda delle necessità)
# Spesso è utile eseguirle se si vuole essere sicuri che gli indici siano allineati
echo "Index Search configuration..."
/usr/local/bin/invenio index init
/usr/local/bin/invenio rdm-records rebuild-index
/usr/local/bin/invenio communities rebuild-index
/usr/local/bin/invenio rdm-records fixtures

echo "==> Process ended with success!"s rebuild-index
/usr/local/bin/invenio communities rebuild-index
/usr/local/bin/invenio rdm-records fixtures