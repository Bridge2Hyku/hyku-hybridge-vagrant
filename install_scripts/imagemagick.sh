############
# ImageMagick
############

echo "Installing ImageMagick"

IMMVERSION=6.9.10-12
SHARED_DIR=$1

if [ -f "$SHARED_DIR/install_scripts/config" ]; then
  . $SHARED_DIR/install_scripts/config
fi

if [ ! -f "$DOWNLOAD_DIR/ImageMagick-$IMMVERSION.tar.gz" ]; then
  echo -n "Downloading ImageMagic..."
  wget -q "https://www.imagemagick.org/download/ImageMagick-$IMMVERSION.tar.gz" -O "$DOWNLOAD_DIR/ImageMagick-$IMMVERSION.tar.gz"
  echo " done"
fi

cp $DOWNLOAD_DIR/ImageMagick-$IMMVERSION.tar.gz /tmp
cd /tmp
tar -xzf ImageMagick-$IMMVERSION.tar.gz
cd ImageMagick-$IMMVERSION
./configure --with-openjp2=yes
make && make install
ldconfig /usr/local/lib
