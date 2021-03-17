FROM centos:8
# Install the repository configuration
RUN dnf -y install https://yum.enterprisedb.com/edbrepos/edb-repo-latest.noarch.rpm

# Replace 'USERNAME:PASSWORD' below with your username and password for the EDB repositories
# Visit https://www.enterprisedb.com/user to get your username and password
RUN  sed -i "s@<username>:<password>@USERNAME:PASSWORD@" /etc/yum.repos.d/edb.repo

# Install EPEL repository
RUN  dnf -y install epel-release

# Enable the powertools repository since EPEL packages may depend on packages from it
#RUN  dnf  -y install 'dnf-command(config-manager) --set-enabled powertools'

# Disable the built-in PostgreSQL module:
RUN  dnf -qy module disable postgresql

# Install selected packages
RUN  dnf -y install edb-as13-server 


EXPOSE 5444

# Initialize Database cluster
USER enterprisedb
RUN PGSETUP_INITDB_OPTIONS="-E UTF-8" /usr/edb/as13/bin/initdb -D /var/lib/edb/data
RUN /usr/edb/as13/bin/pg_ctl -D /var/lib/edb/data/ start && /usr/edb/as13/bin/psql -d postgres -c "alter user enterprisedb identified by enterprisedb"
RUN echo "host postgres enterprisedb    0.0.0.0/0  md5" >> /var/lib/edb/data/pg_hba.conf
# Start Database server

CMD ["/usr/edb/as13/bin/edb-postgres", "-D", "/var/lib/edb/data/"]


#RUN systemctl start edb-as-13

# Connect to the database server
# sudo su - enterprisedb
# psql postgres
