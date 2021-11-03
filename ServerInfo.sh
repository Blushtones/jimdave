# Tells us Linux Distro info, and version info for php, mysql, and apache. Also if phpmyadmin is installed.
lsb_release -a; mysql -V; php -v; apache2 -v; dpkg --list | grep phpmyadmin
