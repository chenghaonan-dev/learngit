#!/bin/bash
#添加dns
echo "nameserver 8.8.8.8">>/etc/resolv.conf
#更换aliyun源
cd /etc/apt/ && mv sources.list sources.list_`date +%Y_%M_%d`
cat sources.list <<-EOF
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
EOF
apt-get update
#配置密钥
which /usr/bin/expect
[ $? -ne 0 ] && apt-get -y install expect 
if [ ! -e /root/.ssh/id_rsa.pub ];then
	/usr/bin/expect <<-EOF
	spawn ssh-keygen
	expect "*.ssh/id_rsa):" 
	send "\n"
	expect "*passphrase):"  
	send "\n"
	expect "*again:"        
	send "\n"
	expect eof
	EOF
fi
#推送公钥
/usr/bin/expect <<-EOF
	spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@47.95.7.182 -p40022
	expect "(yes/no)?"
	send "yes\n"
	expect "password:"
	send "Wlm2710361\n"
	expect eof
	EOF
#打通隧道
which autossh
[ $? -ne 0 ] && apt-get -y install autossh
read -p "请输入远程服务器需要开启的端口：" port
autossh -p40022 -NR $port:localhost:22 root@47.95.7.182 &




