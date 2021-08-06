# Cuirator Box

Barebones CentOS 7 box for [Cuirator](https://github.com/cu-library/cuirator) development and testing.

Uses PostgreSQL for development db and SQLite for test db. 

Fedora and Solr run in Jetty with fcrepo_wrapper and solr_wrapper.

Edit env vars in `config` then

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

# Start Redis
redis-server
```

Create default admin set

```
cd /home/vagrant/cuirator

rails hyrax:default_admin_set:create
```

Start rails console

```
cd /home/vagrant/cuirator

rails console
```

In the console, create admin role and user

```
admin_role = Role.create(name: 'admin')

admin_user = User.create!(
  :display_name=> 'User Name',
  :email=>'username@domain',
  :password=>'password')

admin_role.users << admin_user
```
