#!/bin/bash
set -e
mkdir -p /run/sshd          # sin esto sshd crash-loopea
ssh-keygen -A               # host keys en primer arranque
# omp/bun accesibles para el usuario omp tras recreates
ln -sf /root/.bun/bin/bun /usr/local/bin/bun 2>/dev/null || true
ln -sf /root/.bun/bin/omp /usr/local/bin/omp 2>/dev/null || true
chmod -R a+rX /root/.bun 2>/dev/null || true
if [ -n "$OMP_SSH_PUBKEY" ]; then
  mkdir -p /home/omp/.ssh
  echo "$OMP_SSH_PUBKEY" > /home/omp/.ssh/authorized_keys
  chmod 700 /home/omp/.ssh && chmod 600 /home/omp/.ssh/authorized_keys
  chown -R omp:omp /home/omp/.ssh
fi
exec /usr/sbin/sshd -D -e   # primer plano
