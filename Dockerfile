FROM oven/bun:1.3.14-slim
ENV BUN_INSTALL="/usr/local/bun" PATH="/usr/local/bun/bin:${PATH}"
RUN apt-get update \
  && apt-get install -y --no-install-recommends bash ca-certificates git ripgrep openssh-server passwd \
  && rm -rf /var/lib/apt/lists/*
RUN bun install -g @oh-my-pi/pi-coding-agent
RUN useradd -m -s /bin/bash omp
# binario omp accesible para todos (BUN_INSTALL ya es público)
RUN ln -sf /usr/local/bun/bin/bun /usr/local/bin/bun \
  && ln -sf /usr/local/bun/bin/omp /usr/local/bin/omp
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
WORKDIR /workspace
EXPOSE 22
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
