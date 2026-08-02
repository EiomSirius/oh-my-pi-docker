#!/bin/bash
set -e
mkdir -p /run/sshd          # sin esto sshd crash-loopea
ssh-keygen -A               # host keys en primer arranque
if [ -n "$OMP_SSH_PUBKEY" ]; then
  mkdir -p /home/omp/.ssh
  echo "$OMP_SSH_PUBKEY" > /home/omp/.ssh/authorized_keys
  chmod 700 /home/omp/.ssh && chmod 600 /home/omp/.ssh/authorized_keys
  chown -R omp:omp /home/omp/.ssh
fi
exec /usr/sbin/sshd -D -e   # primer plano
