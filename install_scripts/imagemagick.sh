############
# ImageMagick
############

echo "Installing ImageMagick"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/install_scripts/config" ]; then
  . $SHARED_DIR/install_scripts/config
fi

if [ ! -f "$DOWNLOAD_DIR/ImageMagick-6.9.10-11.tar.gz" ]; then
  echo -n "Downloading ImageMagic..."
  wget -q "https://www.imagemagick.org/download/ImageMagick-6.9.10-11.tar.gz" -O "$DOWNLOAD_DIR/ImageMagick-6.9.10-11.tar.gz"
  echo " done"
fi

cp $DOWNLOAD_DIR/ImageMagick-6.9.10-11.tar.gz /tmp
cd /tmp
tar -xzf ImageMagick-6.9.10-11.tar.gz
cd ImageMagick-6.9.10-11
./configure --with-openjp2=yes
make && make install
ldconfig /usr/local/lib