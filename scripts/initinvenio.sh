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
/usr/local/bin/invenio rdm-records rebuild-index
/usr/local/bin/invenio communities rebuild-index
/usr/local/bin/invenio rdm-records fixtures