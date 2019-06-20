# docker-ubuntu-lamp
Simple base image to setup All-In-One docker container that has Apache2 http, PHP 7.2, MySQL 5.7 for simple deployed demo purposes.
## Avaliable settings
* `MYSQL_DB_NAME`, default `database` - name for database to be created.
* `DB_USER`, default `user` - username to be created
* `DB_PASS`, default `secret` - password for `DB_USER`
## Docker image customization
`bootstrap.sh` executes all scripts from `/scripts` that ends with `.sh` and are executable.
