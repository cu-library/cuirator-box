# Install PostgreSQL

# Install server & contrib packages
yum install -y postgresql-server
yum install -y postgresql-contrib

# Run initdb
/bin/postgresql-setup initdb
# @todo can be re-run but confirm creates /var/lib/pgsql/initdb.log

# Start PostgreSQL service
systemctl enable postgresql.service
systemctl start postgresql

# Create Hyrax database & user
sudo -u postgres createuser --createdb hyrax
sudo -u postgres psql -c "ALTER USER hyrax WITH PASSWORD 'hyrax';"

sudo -u postgres createdb --owner=hyrax --encoding=utf8 'development'
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE development TO hyrax;"

# Back up and modify /var/lib/pgsql/data/pg_hba.conf to allow hyrax user to
# connect to database.
#
#  IPv4 local connections:
# host    all             hyrax           127.0.0.1/32            password
# host    all             all             127.0.0.1/32            ident

if grep hyrax /var/lib/pgsql/data/pg_hba.conf ; then
    echo User hyrax already added to pg_hba.conf
else
  MODDATE=$(date +'%F:%R')
  HYRAX_CONF="host    all             hyrax           127.0.0.1/32            password"
  if sed --in-place=.$MODDATE "/IPv4 local connections/ a ${HYRAX_CONF}" /var/lib/pgsql/data/pg_hba.conf ; then
    echo User hyrax added to pg_hba.conf
    systemctl restart postgresql
  fi
fi
