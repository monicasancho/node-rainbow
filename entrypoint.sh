#!/bin/sh

# Update current user uid
sed -i "s/${USERNAME}:x:[0-9][0-9]*:/${USERNAME}:x:`id -u`:/" /etc/passwd

# SSH
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \
ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa && \
ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 && \
/usr/sbin/sshd 

# Wetty
wetty -p ${WTY_PORT:-3000} --sshport ${SSH_PORT:-22} --sshuser ${USERNAME:-app} &

# Extra Runs
${RUNEXTRA:-echo "No extra runs"}

# Default exec
EXEC=${EXEC:-npm start --prefix /usr/src/node-red -- --userDir /data}

# Exec ARGS or EXEC
exec ${@:-$EXEC}


