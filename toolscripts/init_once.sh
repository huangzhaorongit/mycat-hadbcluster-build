#!/bin/bash

# 拉取 mysql docker 镜像
# docker pull mysql:5.7
# docker images

# 主数据库服务器
docker run \
    -p 33061:3306 \
    --name serverone \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/serverone.cnf:/etc/mysql/mysql.conf.d/serverone.cnf \
    -e MYSQL_ROOT_PASSWORD=112358 \
    -d mysql:5.7
sleep 1

# 从数据库服务器
docker run \
    -p 33062:3306 \
    --name servertwo \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/servertwo.cnf:/etc/mysql/mysql.conf.d/servertwo.cnf \
    -e MYSQL_ROOT_PASSWORD=112358 \
    -d mysql:5.7
sleep 1

docker run \
    -p 33063:3306 \
    --name serverthree \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/serverthree.cnf:/etc/mysql/mysql.conf.d/serverthree.cnf \
    -e MYSQL_ROOT_PASSWORD=112358 \
    -d mysql:5.7
sleep 1

docker run \
    -p 33064:3306 \
    --name serverfour \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/serverfour.cnf:/etc/mysql/mysql.conf.d/serverfour.cnf \
    -e MYSQL_ROOT_PASSWORD=112358 \
    -d mysql:5.7
sleep 1
