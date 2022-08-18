## Docker Container

The `docker/Dockerfile` file extends the `tailscale/tailscale`
[image][1] with an entrypoint script that starts the Tailscale daemon and runs
`tailscale up` using an [auth key][2] and the relevant advertised [CIDR block][3].

The Docker container must be built and pushed to an ACR repository so that it can be refrenced during deployment.

### Build locally with Docker and [push image to ACR][4]
```bash
docker build \
  --tag tailscale-subnet-router:v1 \
  --file ./docker/tailscale.Dockerfile \
  .

# Optionally override the tag for the base `tailscale/tailscale` image
docker build \
  --build-arg TAILSCALE_TAG=v1.29.18 \
  --tag tailscale-subnet-router:v1 \
  --file ./docker/tailscale.Dockerfile \
  .
```

### Build remotely using [Azure Container Registry Tasks][5] with Azure CLI
```bash
ACR_NAME=<registry-name>
az acr build --registry $ACR_NAME --image tailscale:v1 .

# Optionally override the tag for the base `tailscale/tailscale` image
ACR_NAME=<registry-name>
az acr build --registry $ACR_NAME --build-arg TAILSCALE_TAG=v1.29.18 --image tailscale:v1 .
```

[1]: https://hub.docker.com/r/tailscale/tailscale
[2]: https://tailscale.com/kb/1085/auth-keys/
[3]: https://tailscale.com/kb/1019/subnets/
[4]: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli
[5]: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tutorial-quick-task