# v2ray-dfanso

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

   Change the following line:

   ```
   sudo certbot certonly --standalone --non-interactive --agree-tos --email youremail@outlook.com --domains vpn.domain.dev
   ```

   ```
   bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh) << EOF
y
userName
password
31402
EOF
   ```

   Replace `youremail@outlook.com` with the email address you want to use for the SSL certificate, and `vpn.domain.dev` with your desired domain.

After the Terraform apply completes, you can access the X-UI control panel at `http://vpn.domain.dev`. Use the root password you provided in the `terraform.tfvars` file to log in.

## License

This project is licensed under the [MIT License](LICENSE).
