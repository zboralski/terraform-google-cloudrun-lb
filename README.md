# Terraform Google Cloud Run Load Balancer

This Terraform module provisions a load balancer for Google Cloud Run services, with support for SSL, Google-managed SSL certificates, and IP-based access control.

## Features

- Creates a global IP address for the load balancer
- Sets up a regional network endpoint group (NEG) for the Cloud Run service
- Provisions a security policy to restrict access based on authorized IP ranges
- Supports SSL and Google-managed SSL certificates for custom domains
- Configures HTTP to HTTPS redirect

## Prerequisites

- Terraform v0.13 or later
- Google Cloud SDK (gcloud) installed and configured with appropriate permissions
- A Google Cloud Project
- A Cloud Run service deployed within the project

## Architecture

```text
                          +-----------------------+
                          | Google Cloud Project  |
                          +-----------+-----------+
                                      |
                                      v
              +----------------------------------------+
              | Load Balancer (with Global IP address) |
              +----------------+-----------------------+
                               |
                               v
               +---------------------------+
               | Network Endpoint Group    |
               | (Serverless, Cloud Run)   |
               +------------+--------------+
                            |
                            v
               +------------------------+
               | Cloud Run Service      |
               +------------------------+
```

## Usage

To use the module, include it in your Terraform configuration and provide the necessary inputs:

```hcl
module "cloudrun_lb" {
  source = "path/to/terraform-google-cloudrun-lb"

  name                            = "your-load-balancer-name"
  project                         = "your-gcp-project-id"
  location                        = "your-gcp-region"
  service                         = "your-cloud-run-service-name"
  authorized_ip_ranges            = ["1.2.3.4/32", "5.6.7.8/32"]
  managed_ssl_certificate_domains = ["your-custom-domain.com"]
  use_ssl                         = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Load balancer name. | string | | yes |
| project | Google project ID. | string | | yes |
| location | Google location where resources are to be created. | string | | yes |
| service | Cloud Run service name. | string | | yes |
| authorized_ip_ranges | List of authorized IP ranges. | list(string) | `["0.0.0.0/0"]` | no |
| managed_ssl_certificate_domains | List of domains for managed SSL certificate. | list(string) | `[]` | no |
| logging_enabled | Whether to enable logging for the load balancer. | bool | `true` | no |
| logging_sample_rate | The percentage of requests to be logged, as a value between 0.0 and 1.0. | number | `1.0` | no |

## Outputs

The following output is provided by the module:

| Name | Description | Type |
|------|-------------|------|
| address | The IP address of the Cloud Run load balancer. | string |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Acknowledgements

The module is based on the tutorial found in this Medium article by Shadab Ambat: [Firewall your Cloud Run service using Terraform](https://shadabambat1.medium.com/firewall-your-cloud-run-service-using-terraform-582848679eab).

## Contributing

Contributions to this project are welcome! To contribute, please follow these steps:

1. Fork the repository on GitHub.
2. Clone your forked repository to your local machine.
3. Create a new branch with a descriptive name for your changes.
4. Make your changes in the new branch.
5. Commit your changes and write a clear, descriptive commit message.
6. Push your branch with the changes to your fork on GitHub.
7. Open a pull request from your fork's branch to the original repository's main branch.
8. Address any feedback or requested changes provided during the review process.
9. Once your changes are approved, they will be merged into the main branch.

Please ensure your changes follow best practices and adhere to the project's coding standards. Don't forget to update documentation and tests as needed.