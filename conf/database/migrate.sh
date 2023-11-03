#!/bin/bash

if [ -f .env ]; then
  export $(cat .env | xargs)
fi

export dev_url=${WP_HOME}

mysql -uroot -p$MYSQL_ROOT_PASSWORD -D$MYSQL_DATABASE -e "

UPDATE ${DB_PREFIX}options SET option_value = REPLACE(option_value, '${PRODUCTION_URL}', '${dev_url}') WHERE option_name = 'home' OR option_name = 'siteurl'; 
UPDATE ${DB_PREFIX}posts SET guid = REPLACE(guid, '${PRODUCTION_URL}', '${dev_url}'); 
UPDATE ${DB_PREFIX}posts SET post_content = REPLACE(post_content, '${PRODUCTION_URL}', '${dev_url}'); 
UPDATE ${DB_PREFIX}posts SET post_content = REPLACE(post_content, 'src=\"${PRODUCTION_URL}\"', 'src=\"${dev_url}\"'); 
UPDATE ${DB_PREFIX}posts SET guid = REPLACE(guid, '${PRODUCTION_URL}', '${dev_url}') WHERE post_type = 'attachment'; 
UPDATE ${DB_PREFIX}postmeta SET meta_value = REPLACE(meta_value, '${PRODUCTION_URL}', '${dev_url}');"
