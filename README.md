# omp (Oh My Pi) container with SSH access

Container for the [omp](https://omp.sh) AI coding agent, deployed in Coolify.
SSH access on port 2225 (host) -> 22 (container), key-only auth.

## Usage
```bash
ssh -i ~/.ssh/omp_agent -p 2225 omp@85.208.48.210
# then run: omp
```

Image: `ghcr.io/eiomsirius/oh-my-pi-docker:latest` (built in GitHub Actions)
