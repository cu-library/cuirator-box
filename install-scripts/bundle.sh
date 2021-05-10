# Configure app for development & testing

# @todo don't rerun if already set
bundle config set --local with 'development test'

# Install gems
bundle install

# needed to run db:migrate before app would load -- ok
# ran assets:precompile before starting servers again -- also ok
