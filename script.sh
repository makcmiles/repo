echo "Копирование спецификации"
cp ./config/nginx.spec /root/rpmbuild/SPECS/nginx.spec
echo "установка зависимостей"
yum-builddep -y /root/rpmbuild/SPECS/nginx.spec
echo "Установка nginx"
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.24.0-1.el8.ngx.x86_64.rpm
systemctl start nginx
systemctl status nginx
echo "Создание репозитроия"
mkdir -p /usr/share/nginx/html/repo
cp /root/rpmbuild/RPMS/x86_64/nginx-1.24.0-1.el8.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.1.0/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-11.el8.x86_64.rpm -O /usr/share/nginx/html/repo/percona-orchestrator-3.2.6-11.el8.x86_64.rpm 
createrepo /usr/share/nginx/html/repo/
echo "Копирование default.conf"
cp -f ./config/default.conf /etc/nginx/conf.d/default.conf
echo "Перезапуск nginx"
cd /root
nginx -t
nginx -s reload
echo "Подключение репозитроия"
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
echo "Установка оркестратора из репозитория"
yum install percona-orchestrator.x86_64 -y
