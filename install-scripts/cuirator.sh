# Check out Cuirator repository, bundle config and install
# Run this script as non-privileged user

# @todo just make this vagrant $HOME but confirm user
INSTALL_DIR="/home/vagrant"
CUIRATOR_DIR="cuirator"
CUIRATOR_INSTALL_DIR="$INSTALL_DIR/$CUIRATOR_DIR"
CUIRATOR_URL="https://github.com/cu-library/cuirator.git"

# Check out repository
if [ -e $CUIRATOR_INSTALL_DIR ]; then
    echo Repository $CUIRATOR_INSTALL_DIR already exists
else
    cd $INSTALL_DIR
    git clone $CUIRATOR_URL
fi

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

# Rake tasks: migrate & precompile
rake db:migrate
rake db:precompile
