############
# ImageMagick
############

echo "Installing ImageMagick"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/install_scripts/config" ]; then
  . $SHARED_DIR/install_scripts/config
fi

if [ ! -f "$DOWNLOAD_DIR/ImageMagick.tar.gz" ]; then
  echo -n "Downloading ImageMagic..."
  wget -q "https://www.imagemagick.org/download/ImageMagick.tar.gz" -O "$DOWNLOAD_DIR/ImageMagick.tar.gz"
  echo " done"
fi

cp $DOWNLOAD_DIR/ImageMagick.tar.gz /tmp
cd /tmp
tar -xzf ImageMagick.tar.gz
cd ImageMagick-*
./configure --with-openjp2=yes
make && make install
ldconfig /usr/local/lib
