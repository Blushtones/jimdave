#!/bin/bash

docker-compose up -d
# install dev tools
docker exec -it -w /var/www/lamrt.org.uk/ drupal bash -c "COMPOSER_MEMORY_LIMIT=-1 composer require --dev drupal/drupal-extension:~3.0"

# create directory
mkdir drupal/lamrt.org.uk/testing

# pull testing git
git clone git@github.com:Blushtones/testing.git drupal/lamrt.org.uk/testing

# set symlinks
docker exec -it drupal bash -c "ln -s /var/www/lamrt.org.uk/testing/behat.yml /var/www/lamrt.org.uk/behat.yml"
docker exec -it drupal bash -c "ln -s /var/www/lamrt.org.uk/testing/features/ /var/www/lamrt.org.uk/"

# set up hosts file if required
echo ""
while true; do
    read -p "Are you testing within a local docker environment(y/n)" yn
    case $yn in
        [Yy]* ) source drupal/lamrt.org.uk/testing/create_hosts.sh; break;;
        [Nn]* ) echo "System ready for testing!";exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ""
echo ""
echo "For Drush testing the following should be added to behat.yml"
echo "drush:"
echo "  root: /var/www/lamrt.org.uk"
echo "  binary: 'vendor/bin/drush'"

echo ""
echo ""
echo "Add the following to your profile for ease of use:"
echo "alias behat='docker exec -it -w \"/var/www/lamrt.org.uk/\" drupal \"vendor/bin/behat\"'"
echo ""
echo ""
echo "System ready for testing!"
echo ""
echo ""