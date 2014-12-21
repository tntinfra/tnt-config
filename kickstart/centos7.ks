#version=RHEL7
# System authorization information
auth --enableshadow --passalgo=sha512

# Use network installation
url --url="http://mirror.centos.org/centos/7/os/x86_64/"

cmdline

ignoredisk --only-use=vda
clearpart --drives=vda --all
part pv.01 --size 1 --grow --ondisk=vda
part /boot --fstype=ext4 --asprimary --size=512 --asprimary --ondisk=vda
volgroup rootvg pv.01
logvol /    --vgname=rootvg --size=5000 --name=rootlv
logvol /tmp --vgname=rootvg --size=512  --name=tmplv
logvol swap --vgname=rootvg --size=2048 --name=swaplv

services --enabled=NetworkManager,sshd

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'

# System language
lang en_US.UTF-8
timezone --utc Europe/Vienna

# Network information
network  --bootproto=dhcp --device=eth0 --ipv6=auto --activate
network  --hostname=noc.tntinfra.net

rootpw vagrant
user --name=vagrant --plaintext --password vagrant --groups=vagrant,wheel

reboot

repo --name="Puppetlabs Repository"  --baseurl=https://yum.puppetlabs.com/el/7/products/x86_64/

%packages --nobase
@core --nodefaults
-aic94xx-firmware*
-alsa-*
-iwl*firmware
-NetworkManager*
-iprutils
%end

%post --log=/root/anaconda-post.log
# CIS 1.1.6
echo "/tmp      /var/tmp    none    bind    0 0" >> /etc/fstab
# CIS 1.1.14-1.1.16
awk '$2~"^/dev/shm$"{$4="nodev,noexec,nosuid"}1' OFS="\t" /etc/fstab >> /tmp/fstab
mv /tmp/fstab /etc/fstab
restorecon -v /etc/fstab && chmod 644 /etc/fstab

# /etc/sysctl.conf
cat << 'EOF' >> /etc/sysctl.conf

# CIS Benchmark Adjustments
kernel.exec-shield = 1                                  # CIS 1.6.2
kernel.randomize_va_space = 2                           # CIS 1.6.3
net.ipv4.ip_forward = 0                                 # CIS 4.1.1
net.ipv4.conf.all.send_redirects = 0                    # CIS 4.1.2
net.ipv4.conf.default.send_redirects = 0                # CIS 4.1.2
net.ipv4.conf.all.accept_source_route = 0               # CIS 4.2.1
net.ipv4.conf.default.accept_source_route = 0           # CIS 4.2.1
net.ipv4.conf.all.accept_redirects = 0                  # CIS 4.2.2
net.ipv4.conf.default.accept_redirects = 0              # CIS 4.2.2
net.ipv4.conf.all.secure_redirects = 0                  # CIS 4.2.3
net.ipv4.conf.default.secure_redirects = 0              # CIS 4.2.3
net.ipv4.icmp_echo_ignore_broadcasts = 1                # CIS 4.2.5
net.ipv4.icmp_ignore_bogus_error_responses = 1          # CIS 4.2.6
net.ipv4.conf.all.rp_filter = 1                         # CIS 4.2.7
net.ipv4.conf.default.rp_filter = 1                     # CIS 4.2.7
net.ipv4.tcp_syncookies = 1                             # CIS 4.2.8
EOF

yum -y -t -e 0 install puppet

exit 0
%end
