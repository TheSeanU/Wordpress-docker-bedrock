#!/bin/sh
target_directory="/app"
target_wp="/app/web/wp"

if [ -f .env ]; then
  export $(cat .env | xargs)
fi

if [ -z "$(ls -A $target_directory)" ]; then
  composer create-project roots/bedrock $target_directory
  sleep 5

  wp db create --allow-root
  wp core install --allow-root --path=$target_wp --url="${WP_HOME}" --title="${WP_TITLE}" --admin_user="${WP_USERNAME}" --admin_password="${WP_PASSWORD}" --admin_email="${WP_EMAIL}"

  sleep 5

  ./database/migrate.sh
else
  echo "Target directory '$target_directory' is not empty. Skipping custom setup."
fi

exec php-fpm