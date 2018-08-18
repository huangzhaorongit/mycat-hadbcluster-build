# 基于MyCAT + KeepAlived + HaProxy + MySQL + Docker 的高可用数据库集群搭建

## 使用Docker模拟搭建四个MySQL服务器

#### Docker容器搭建与配置

+ Docker容器中MySQL配置
```
mysql --help | grep my.cnf    # /etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf ，默认按这个顺序查找，知道找到my.cnf作为配置文件。我的Linux上找到了/etc/mysql/my.cnf
# 但是内容如下
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/
# 其实是将my.cnf拆分成了这两个目录下的四个.cnf文件
# 修改配置文件，主要是开启二进制日志以及为MySQL服务器分配一个唯一id，以及开启慢查询日志
```

+ MySQL Docker镜像下载与容器启动
```
docker search mysql
docker pull mysql:5.7
docker images

# 启动容器
# 主数据库服务器
docker run 
    -p 33061:3306 
    --name serverone 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/serverone.cnf:/etc/mysql/mysql.conf.d/serverone.cnf 
    -e MYSQL_ROOT_PASSWORD=112358 
    -d mysql:5.7

# 从数据库服务器
# TODO: 创建一个专门的用户连接数据库而不是用root用户。
docker run 
    -p 33062:3306 
    --name servertwo 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/servertwo.cnf:/etc/mysql/mysql.conf.d/servertwo.cnf 
    -e MYSQL_ROOT_PASSWORD=112358 
    -d mysql:5.7

docker run 
    -p 33063:3306 
    --name serverthree 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/serverthree.cnf:/etc/mysql/mysql.conf.d/serverthree.cnf 
    -e MYSQL_ROOT_PASSWORD=112358 
    -d mysql:5.7

docker run 
    -p 33064:3306 
    --name serverfour 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf 
    -v /home/lee/mydisk/mywork/web_module/mycat/mycat-hadbcluster-build/conf/serverfour.cnf:/etc/mysql/mysql.conf.d/serverfour.cnf 
    -e MYSQL_ROOT_PASSWORD=112358 
    -d mysql:5.7

# 进入容器命令行
docker exec -it <container_id> /bin/bash
# 通过映射到宿主机的端口连接
mysql -uroot -p --port=33061
# 查看生成的容器的名字和IP地址
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress}}' $(docker ps -aq)
结果如下
/serverfour - 172.17.0.5
/serverthree - 172.17.0.4
/servertwo - 172.17.0.3
/serverone - 172.17.0.2
下面这两种方式都可以连接
mysql -uroot -p -h127.0.0.1 -P33061
mysql -uroot -p -h172.17.0.2 -P3306
```

注意：   
远程连接时，mysql -uroot -p -h127.0.0.1 -P33061，这里的IP地址必须是四个数，不能为localhost; 使用端口连接也必须指定IP。  
mysql: [Warning] World-writable config file '/etc/mysql/mysql.conf.d/mysqld.cnf' is ignored.
出现这个问题是因为cnf文件所有人可写，需要将这个文件权限改为只允许所属用户可写。  

#### 以书店电商为案例,准备数据

#### 实现主从复制

#### 实现读写分离

#### 实现

## 使用MyCAT中间件

#### 对数据库垂直和水平切分 



