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
yum -y install sqlite-devel

# Imagemagick, LibreOffice for processing
yum -y install ImageMagick libreoffice

# Redis
yum -y install redis

## ffmpeg
yum -y localinstall --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
yum -y install ffmpeg

# Universal Viewer requires recent version of Node.js
# Install Nodesource repo
if yum repolist | grep nodesource > /dev/null ; then
  echo Nodesource repo already exists
else
  curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
fi

# Install node and yarn
yum install -y nodejs
npm install -g yarn

# Stop firewalld
systemctl stop firewalld.service
