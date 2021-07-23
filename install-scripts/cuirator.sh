# Check out Cuirator repository, bundle config and install
# Run this script as non-privileged user

# Script args
SHARED_DIR=$1

# Config files
CONFIG_DIR=$SHARED_DIR
DOT_ENV=".env"
DOT_PROFILE=".bash_profile"
DOT_SOLR_WRAPPER=".solr_wrapper"
DOT_FCREPO_WRAPPER=".fcrepo_wrapper"
DEVELOPMENT_CONFIG="development.rb"

# Cuirator install locations & source
INSTALL_DIR=$HOME
CUIRATOR_DIR="cuirator"
CUIRATOR_INSTALL_DIR="$INSTALL_DIR/$CUIRATOR_DIR"
CUIRATOR_URL="https://github.com/cu-library/cuirator.git"

# Create ~/.env
if [ -e $HOME/$DOT_ENV ]; then
    echo $HOME/$DOT_ENV already exists
else
    cp $CONFIG_DIR/$DOT_ENV $HOME/$DOT_ENV
fi

# Add .env to bash profile & export vars
if grep "source \$HOME/$DOT_ENV" $HOME/$DOT_PROFILE > /dev/null ; then
    echo Environment vars already added to $HOME/$DOT_PROFILE
else
    echo "set -o allexport; source \$HOME/$DOT_ENV; set +o allexport" >> $HOME/$DOT_PROFILE
fi

# Check out repository
if [ -e $CUIRATOR_INSTALL_DIR ]; then
    echo Repository $CUIRATOR_INSTALL_DIR already exists
else
    cd $INSTALL_DIR
    git clone $CUIRATOR_URL
fi

# Create ~/cuirator/.solr_wrapper
if [ -e $CUIRATOR_INSTALL_DIR/$DOT_SOLR_WRAPPER ]; then
    echo $CUIRATOR_INSTALL_DIR/$DOT_SOLR_WRAPPER already exists
else
    cp $CONFIG_DIR/$DOT_SOLR_WRAPPER $CUIRATOR_INSTALL_DIR/$DOT_SOLR_WRAPPER
fi

# Create ~/cuirator/.fcrepo_wrapper
if [ -e $CUIRATOR_INSTALL_DIR/$DOT_FCREPO_WRAPPER ]; then
    echo $CUIRATOR_INSTALL_DIR/$DOT_FCREPO_WRAPPER already exists
else
    cp $CONFIG_DIR/$DOT_FCREPO_WRAPPER $CUIRATOR_INSTALL_DIR/$DOT_FCREPO_WRAPPER
fi

# Copy config for development environment
cp $CONFIG_DIR/$DEVELOPMENT_CONFIG "$CUIRATOR_INSTALL_DIR/config/environments"

# Update Bundler
# @todo check version in Gemfile.lock before running update
# @todo or move this to ruby.sh & set version w/o Gemfile check
if bundle --version | grep '2.2.9' > /dev/null ; then
    echo `bundle --version` 'already installed'
else
    sudo gem install bundler -v 2.2.9
fi

cd $CUIRATOR_INSTALL_DIR

# Configure app for development & testing
if bundle config list | grep "\[:development, :test\]" ; then
    echo "Already set: bundle config set --local  with 'development test'";
else
    bundle config set --local with 'development test'
fi

# Install gems
bundle install

# Install Universal Viewer
yarn install

# Rails tasks: migrate & precompile
rails db:migrate
rails assets:precompile
