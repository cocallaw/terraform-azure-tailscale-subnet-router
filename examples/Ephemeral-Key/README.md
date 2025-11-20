# Ephemeral Key Example

This example demonstrates deploying a Tailscale subnet router using an ephemeral auth key. When using ephemeral keys, the device is automatically removed from the Tailnet when it goes offline, so state persistence is not needed.

## Key Differences

- `enable_state_persistence` is set to `false`
- `storage_account_name` is not required since no Storage Account will be created
- The ACI container will not mount an Azure File Share for Tailscale state

## Usage

When generating your Tailscale auth key, make sure to check the "Ephemeral" option in the Tailscale admin console. This ensures that the device is automatically removed from your Tailnet when the container goes offline.

## Deployment

Replace the placeholder values in `main.tf` with your actual Azure and Tailscale configuration:

```bash
terraform init
terraform plan
terraform apply
```

## Benefits of Ephemeral Keys

- Automatic cleanup: Devices are removed from the Tailnet when they go offline
- Reduced cost: No Storage Account is created
- Simplified deployment: No need to manage persistent state
- Ideal for temporary or short-lived deployments
