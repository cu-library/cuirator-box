# Install FITS - File Information Tool Set

# FITS vars
# @todo check FITS version in hyrax-ansible on ops
FITS_VERSION="1.5.0"
FITS_SRC="fits-$FITS_VERSION.zip"
FITS_URL="https://github.com/harvard-lts/fits/releases/download/$FITS_VERSION/$FITS_SRC"
FITS_INSTALL_DIR="/opt/fits-$FITS_VERSION"

# Download & install FITS
if [ -e $FITS_INSTALL_DIR ]; then
    echo FITS version `/opt/fits/fits.sh -v` already installed
else
    mkdir $FITS_INSTALL_DIR
    cd $FITS_INSTALL_DIR

    # @todo add & verify checksum
    wget --no-verbose $FITS_URL
    unzip $FITS_SRC

    # Make symbolic link for FITS
    ln -s $FITS_INSTALL_DIR /opt/fits
fi
