export DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical
apt-get update
apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
apt-get install -y vim unzip lsof wget openssl tree
nohup wget https://releases.hashicorp.com/vault/1.0.2/vault_1.0.2_linux_amd64.zip &
nohup wget https://releases.hashicorp.com/consul/1.4.2/consul_1.4.2_linux_amd64.zip &
nohup wget https://releases.hashicorp.com/consul-template/0.19.5/consul-template_0.19.5_linux_amd64.zip &
wait %1 %2 %3
cd /usr/local/bin
unzip -o ~ubuntu/vault_1.0.2_linux_amd64.zip
unzip -o ~ubuntu/consul_1.4.2_linux_amd64.zip
unzip -o ~ubuntu/consul-template_0.19.5_linux_amd64.zip

cat > ~ubuntu/.jacobrc <<EOF
vers=1902
shopt -s extglob
export PATH=~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/X/bin:/usr/local/sbin:/usr
/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/go/bin
export PS1="\u@\h:\w (\@  - \d)\n$ ";
if [ "\$USER" == 'root' ]; then export PS1="\u@\h:\w (\@ - \d)\n# "; fi
bind '"\C-i":complete'; set -o vi
export EDITOR=vim TERM=xterm LANG=C PAGER=less LESS=-R HISTCONTROL=ignoredups HISTSIZE=10000 HISTTIMEFORMAT='%F %T '
export PROMPT_COMMAND='history -a'
ls --color=auto &>/dev/null; if [ 0 -eq 0 ]; then alias ls='ls --color=auto' lh='ls -lh' lha='ls -lha' lhtr='ls -lhtr'; fi;
ps ax &>/dev/null || alias pg='ps -ef | egrep -i'; export EDITOR=vi; alias v=vi
alias a=alias ac=apt-cache ag=apt-get c=cat ci='svn ci' cx='chmod +x' f=fg g=egrep h=history \
j=jobs l=ls ld='ls -ld' les='less -N' lsa='ls -a' ltr='ls -ltr' kil='kill' \
pg='ps ax | egrep -i' ifu='ifconfig | egrep "Link|MTU|inet"; netstat -rn' ltt='ls -ltr | tail' \
ng='netstat -an | egrep -i ' s=ssh  ta='tmux a' pug='ps aux | egrep -i ' sd='sudo bash'  \
t=tail wh=which zles=zless cdi='cd /etc/init.d' agug='apt-get upgrade ' agud='apt-get update' \
lhtrt='ls -lhtr | tail ' hg='history | egrep ' v=vim tj="tar jxvf" tf=terraform va=vault
mcd () { mkdir \$1 ; cd \$1; }
if [ -e ~/.bashrc.local ]; then . ~/.bashrc.local; fi
if [ -e ~/.jacobrc.local ]; then . ~/.jacobrc.local; fi
EOF

cd ~ubuntu
chown -R ubuntu ~ubuntu
