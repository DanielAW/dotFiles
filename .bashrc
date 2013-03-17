
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
complete -cf sudo
export LC_LANG=de_DE.utf8
alias vpne='sudo vpnc --application-version "Cisco Systems VPN Client 4.8.02 (0030):Linux"  VPN_Extern'
#alias vpni='sudo vpnc --application-version "Cisco Systems VPN Client 4.8.02 (0030):Linux"  VPN_Intern'
alias vpni='sudo /home/daniel/scripts/go_vpn.sh'
alias vpnd='sudo vpnc-disconnect'
alias vi='vim'
alias dropboxr='/home/daniel/scripts/go_dropbox.sh'
alias ll='ls -la'
#braucht man seit 2.6.38 nicht mehr:
#if [ "$PS1" ] ; then  
#   mkdir -p -m 0700 /dev/cgroup/cpu/user/$$ > /dev/null 2>&1
#   echo $$ > /dev/cgroup/cpu/user/$$/tasks
#   echo "1" > /dev/cgroup/cpu/user/$$/notify_on_release
#fi
