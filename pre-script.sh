echo "Скачивание необходимых пакетов; скачивание nginx и openssl"
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
cd /root
wget -q https://nginx.org/packages/centos/8/SRPMS/nginx-1.24.0-1.el8.ngx.src.rpm
rpm -i nginx-1.2*
wget -q https://www.openssl.org/source/openssl-1.1.1w.tar.gz --no-check-certificate
echo "Распаковка openssl"
tar -xf openssl-1.1.1w.tar.gz
