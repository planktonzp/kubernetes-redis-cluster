FROM hub.bonc:5000/centos:7.2.1511

RUN groupadd -r redis && useradd -r -g redis redis

ENV REDIS_VERSION 4.0.1
ADD redis.tar.gz /usr/local/bin/

RUN mkdir /data \
 && chown redis:redis /data \
 && rm -rf /etc/yum..repos.d/* \
 && curl http://mirrors.163.com/.help/CentOS7-Base-163.repo -o /etc/yum.repos.d/CentOS-Base.repo \
 && yum makecache \
 && yum install epel-release -y \
 && yum makecache \
 && yum install ruby -y \
 && gem install redis \
 && yum remove erase -y \
 && yum clean all

VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
