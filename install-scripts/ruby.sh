# Install ruby-install to install and manage Ruby versions, and Ruby
# @see https://github.com/cu-library/hyrax-ansibles

# Install ruby-install
# @see https://github.com/postmodern/ruby-install

# ruby-install vars
# @todo check w/ hyrax-ansibles deployed on ops
RUBY_INSTALL_VERSION="0.7.1"
RUBY_INSTALL_SRC="v$RUBY_INSTALL_VERSION.tar.gz"
RUBY_INSTALL_URL="https://github.com/postmodern/ruby-install/archive/refs/tags/$RUBY_INSTALL_SRC"
RUBY_INSTALL_SRC_DIR="ruby-install-$RUBY_INSTALL_VERSION"

# Ruby vars
RUBY_VERSION="2.7.2"
RUBY_TARBZ2_SHA256_CHECKSUM="65a590313d244d48dc2ef9a9ad015dd8bc6faf821621bbb269aa7462829c75ed"

# Already installed?
if /usr/local/bin/ruby-install --version 2> /dev/null; then
    echo `/usr/local/bin/ruby-install --version` "already installed"
else
    # Download ruby-install tarball
    # @todo add & verify checksum
    cd /tmp
    wget --no-verbose $RUBY_INSTALL_URL
    tar -xzf $RUBY_INSTALL_SRC

    # Install ruby-install
    cd $RUBY_INSTALL_SRC_DIR
    make install
fi

# install Ruby
if /usr/local/bin/ruby --version 2> /dev/null; then
    echo `/usr/local/bin/ruby --version` "already installed"
else
    # --system to install in /usr/local
    /usr/local/bin/ruby-install ruby --system $RUBY_VERSION --sha256 $RUBY_TARBZ2_SHA256_CHECKSUM

    # Add Ruby installation dir to sudo path
    echo 'Defaults    secure_path="/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin"' > /etc/sudoers.d/addusrlocalbintopath
fi
