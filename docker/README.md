## Docker Container

The `docker/Dockerfile` file extends the `tailscale/tailscale`
[image][1] with an entrypoint script that starts the Tailscale daemon and runs
`tailscale up` using an [auth key][2] and the relevant advertised [CIDR block][3].

By default the module will pull the Subnet Router Docker image from [cocallaw/tailscale-sr on Docker Hub][4]. If you prefer to build and push the Docker image to your own Azure Container Registry, you can use the `docker_image` variable to specify `ACR` instead of `DockerHub`.

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
[4]: https://hub.docker.com/r/cocallaw/tailscale-sr
[5]: https://docs.microsoft.com/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli
[6]: https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-quick-task