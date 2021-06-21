# Cuirator Box

Barebones CentOS 7 box for [Cuirator](https://github.com/cu-library/cuirator) development and testing.

Bash for readability by student contributors.

Uses SQLite only. Fedora and Solr run in Jetty with fcrepo_wrapper and solr_wrapper.

Edit env vars in `config`, then

```
vagrant up
vagrant ssh

cd /home/vagrant/cuirator

# Start fcrepo_wrapper w/ default config in ~/cuirator/.fcrepo_wrapper
fcrepo_wrapper

# Start solr_wrapper w/ default config in ~/cuirator/.solr_wrapper
solr_wrapper

# Start Puma web server
rails server 
```
