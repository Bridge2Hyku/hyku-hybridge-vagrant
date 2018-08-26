############
# Hyku
############

echo "Installing Hyku"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/install_scripts/config" ]; then
  . $SHARED_DIR/install_scripts/config
fi

sudo mkdir -p /var/www/hyku
sudo chown -R vagrant:vagrant /var/www/hyku

cd $HOME_DIR
git clone https://github.com/samvera-labs/hyku.git
mv $HOME_DIR/hyku/* /var/www/hyku
rm -Rf $HOME_DIR/hyku

sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant' CREATEDB;"

. /etc/default/hyku

cd /var/www/hyku

echo "gem 'hybridge', git: 'https://github.com/Bridge2Hyku/hybridge.git'" >> /var/www/hyku/Gemfile

gem install bundler -q
bundle install

bundle exec rake assets:precompile
bundle exec rake db:setup
rails g hybridge:install

echo -en "\nhybridge:\n  filesystem: /data_store\n" >> /var/www/hyku/config/settings/production.yml
echo -en "\nactive_job:\n  queue_adapter: :sidekiq\n" >> /var/www/hyku/config/settings/production.yml

sudo service apache2 restart

sudo cp $SHARED_DIR/config/sidekiq.init /etc/init.d/sidekiq
sudo chmod 755 /etc/init.d/sidekiq
sudo update-rc.d sidekiq defaults
sudo update-rc.d sidekiq enable
sudo /etc/init.d/sidekiq start

echo "Done"
