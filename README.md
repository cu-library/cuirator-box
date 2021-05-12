# Cuirator Box

Barebones CentOS 7 box for [Cuirator](https://github.com/cu-library/cuirator) development and testing.

Uses SQLite only. Fedora and Solr run in Jetty with fcrepo_wrapper and solr_wrapper.

```
vagrant up
vagrant ssh

cd /home/vagrant/cuirator

# Start fcrepo_wrapper
fcrepo_wrapper --port 8984

# Start solr_wrapper
# Solr 8.0.x releases are not supported. See https://github.com/samvera/hyrax/wiki/Hyrax-Development-Guide
# Set collection name 'hydra-development' to match config/solr.yml 
solr_wrapper --port 8983 --version 7.7.3 --collection_name hydra-development

# Start puma
puma -b tcp://0.0.0.0:3000
```
