FROM oven/bun:1.3.14-slim
RUN apt-get update \
  && apt-get install -y --no-install-recommends bash ca-certificates git ripgrep openssh-server passwd \
  && rm -rf /var/lib/apt/lists/*
RUN bun install -g @oh-my-pi/pi-coding-agent
RUN useradd -m -s /bin/bash omp
# Exponer bun/omp a todos los usuarios (el PATH de login no incluye /root/.bun/bin)
RUN ln -sf /root/.bun/bin/bun /usr/local/bin/bun \
  && ln -sf /root/.bun/bin/omp /usr/local/bin/omp \
  && chmod -R a+rX /root/.bun
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
WORKDIR /workspace
EXPOSE 22
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
