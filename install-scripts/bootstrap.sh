# Updates, packages, and Hyrax dependencies that are simple package installs

# Update & add EPEL repo
yum -y update
yum -y install epel-release

# Utilities
yum -y install curl wget unzip bzip2 tar git

# Required to build ruby-install, ruby, and gems
yum -y install make patch gcc gcc-c++ \
    libxslt-devel libxml2-devel postgresql-devel

#
# Hyrax dependencies
#

# Java
yum -y install java-1.8.0-openjdk

# SQLite
# @todo do we need mysql-server mysql-client or can we run with SQLite
yum -y install sqlite-devel

# Imagemagick, LibreOffice for processing
yum -y install ImageMagick libreoffice

# Nodejs from EPEL
yum -y install nodejs

# Redis
yum -y install redis
