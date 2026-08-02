FROM oven/bun:1.3.14-slim
ENV BUN_INSTALL="/usr/local/bun"
RUN apt-get update \
  && apt-get install -y --no-install-recommends bash ca-certificates git ripgrep openssh-server passwd \
  && rm -rf /var/lib/apt/lists/*
RUN bun install -g @oh-my-pi/pi-coding-agent
RUN useradd -m -s /bin/bash omp
# omp accesible para todos; bun real ya vive en /usr/local/bin (imagen base oven/bun)
RUN ln -sf /usr/local/bun/install/global/node_modules/@oh-my-pi/pi-coding-agent/dist/cli.js /usr/local/bin/omp
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
WORKDIR /workspace
EXPOSE 22
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
