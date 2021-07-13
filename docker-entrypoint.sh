#!/bin/sh
sed -i 's@Db = "Yearning"@Db = "$MYSQL_DB"@g' conf.toml
sed -i 's@Host = "127.0.0.1"@Host = "$MYSQL_ADDR"@g' conf.toml
sed -i 's@Port = "3306"@Port = "$MYSQL_PORT"@g' conf.toml
sed -i 's@Password = ""@Password = "$MYSQL_PASSWORD"@g' conf.toml
sed -i 's@User = "root"@User = "$MYSQL_USER"@g' conf.toml
./Yearning install && ./Yearning run 
