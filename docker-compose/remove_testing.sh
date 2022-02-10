#!/bin/bash


# remove dev tools
docker exec -it -w /var/www/lamrt.org.uk/ drupal bash -c "COMPOSER_MEMORY_LIMIT=-1 composer remove --dev drupal/drupal-extension:~3.0"



# remove symlinks
docker exec -it drupal bash -c "rm /var/www/lamrt.org.uk/behat.yml"
docker exec -it drupal bash -c "rm /var/www/lamrt.org.uk/features"

# remove directory
rm -R drupal/lamrt.org.uk/testing

# take down docker stack
docker-compose down

echo ""
echo ""
echo "System taken down!!"
echo ""
echo ""