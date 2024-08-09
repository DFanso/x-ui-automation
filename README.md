# x-ui-automation

This Terraform configuration sets up a Linode instance with a V2Ray server and an X-UI control panel.

## Prerequisites

- Terraform must be installed on your system. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
- You'll need to provide the following values in a `terraform.tfvars` file:
  - `linode_token`: Your Linode API token.
  - `root_pass`: The root password for the Linode instance.
  - `ssh_key`: Your SSH public key for accessing the instance.
  - `instance_label`: A label for the Linode instance.
  - `type`: The Linode instance type (e.g., `g6-nanode-1`).
  - `region`: The Linode region (e.g., `ap-south`).
  - `cloudflare_email`: Your Cloudflare email address.
  - `cloudflare_api_key`: Your Cloudflare API key.
  - `cloudflare_zone_id`: Your Cloudflare zone ID.
  - `record_name`: Your domain name.


- If you dont want to use terraform comment this line on main.tf

   ```
    cloud {

    organization = "DFanso"

    workspaces {
      name = "V2ray"
    }
  }
  ```

## Usage

1. Initialize the Terraform working directory:

   ```
   terraform init
   ```

2. Format the Terraform configuration files:

   ```
   terraform fmt
   ```

3. Create an execution plan:

   ```
   terraform plan
   ```

4. Apply the Terraform configuration:

   ```
   terraform apply
   ```

   This will create the Linode instance and configure the V2Ray server and X-UI control panel.

5. Update the `install_x_ui.sh` script:

```
USERNAME=""
PASSWORD=""
EMAIL=""
DOMAIN=""
```

After the Terraform apply completes, you can access the X-UI control panel at `http://vpn.domain.dev`. Use the root password you provided in the `terraform.tfvars` file to log in.

## Note

- When copying the database, make sure to change the settings table and inbound table domain names accordingly.
- Use a Bash shell to run the Terraform commands, as PowerShell (PWSH) may not work properly.

## License

This project is licensed under the [MIT License](LICENSE).