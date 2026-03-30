# IBM Cloud Virtual Private Endpoint (VPE) Terraform Module

This Terraform module creates IBM Cloud Virtual Private Endpoints (VPE) with flexible configuration options, allowing you to specify the number of VPEs and their locations.

## Features

- ✅ Create multiple Virtual Private Endpoints in a single deployment
- ✅ Configure VPEs across different VPCs and regions
- ✅ Support for multiple subnets per VPE
- ✅ Optional security group assignments
- ✅ Flexible tagging and naming conventions
- ✅ Pre-configured service endpoint CRNs for common IBM Cloud services
- ✅ Comprehensive outputs for integration with other modules

## Prerequisites

- IBM Cloud account
- IBM Cloud API key with appropriate permissions
- Terraform >= 1.3.0
- IBM Cloud Terraform Provider >= 1.59.0
- Existing VPC(s) and subnet(s)

## Usage

### Basic Example - Single VPE (using Resource Group ID)

```hcl
module "vpe" {
  source = "./ibm-vpe-terraform"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "us-south"
  resource_group_id = "your-resource-group-id"

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = "r006-12345678-1234-1234-1234-123456789012"
      subnet_ids = ["0717-12345678-1234-1234-1234-123456789012"]
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.us-south.cloud-object-storage.appdomain.cloud"
      tags       = ["env:prod", "service:cos"]
    }
  ]
}
```

### Basic Example - Single VPE (using Resource Group Name)

```hcl
module "vpe" {
  source = "./ibm-vpe-terraform"

  ibmcloud_api_key    = var.ibmcloud_api_key
  region              = "us-south"
  resource_group_name = "Default"  # Module will lookup the ID automatically

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = "r006-12345678-1234-1234-1234-123456789012"
      subnet_ids = ["0717-12345678-1234-1234-1234-123456789012"]
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.us-south.cloud-object-storage.appdomain.cloud"
      tags       = ["env:prod", "service:cos"]
    }
  ]
}
```

### Multiple VPEs Across Different Locations

```hcl
module "vpe" {
  source = "./ibm-vpe-terraform"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "us-south"
  resource_group_id = "your-resource-group-id"
  prefix            = "myapp"
  tags              = ["project:myapp", "managed-by:terraform"]

  vpe_configurations = [
    {
      name       = "cos-vpe-zone1"
      vpc_id     = "r006-vpc-id-1"
      subnet_ids = [
        "0717-subnet-zone1-id",
        "0717-subnet-zone2-id"
      ]
      target_crn         = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.us-south.cloud-object-storage.appdomain.cloud"
      security_group_ids = ["r006-sg-id-1"]
      tags               = ["zone:1"]
    },
    {
      name       = "kms-vpe-zone2"
      vpc_id     = "r006-vpc-id-2"
      subnet_ids = ["0717-subnet-zone3-id"]
      target_crn = "crn:v1:bluemix:public:kms:us-south:::endpoint:private.us-south.kms.cloud.ibm.com"
      tags       = ["zone:2", "service:kms"]
    },
    {
      name       = "postgres-vpe"
      vpc_id     = "r006-vpc-id-1"
      subnet_ids = ["0717-subnet-zone1-id"]
      target_crn = "crn:v1:bluemix:public:databases-for-postgresql:us-south:::endpoint:private.us-south.databases.appdomain.cloud"
      tags       = ["service:database"]
    }
  ]
}
```

### Using Pre-configured Service Endpoints

The module includes pre-configured CRNs for common IBM Cloud services across multiple regions:

```hcl
module "vpe" {
  source = "./ibm-vpe-terraform"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "eu-gb"
  resource_group_id = "your-resource-group-id"

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = "r018-vpc-id"
      subnet_ids = ["0727-subnet-id"]
      # Use the pre-configured CRN from service_endpoints variable
      target_crn = var.service_endpoints["eu-gb"]["cos"]
    },
    {
      name       = "kms-vpe"
      vpc_id     = "r018-vpc-id"
      subnet_ids = ["0727-subnet-id"]
      target_crn = var.service_endpoints["eu-gb"]["kms"]
    }
  ]
}
```

## Available Service Endpoints

The module provides pre-configured CRNs for the following services across major regions:

- **Cloud Object Storage (COS)** - `cos`
- **Key Protect / HPCS** - `kms`
- **Databases for PostgreSQL** - `databases-for-postgresql`
- **Container Registry** - `container-registry`

Supported regions: `us-south`, `us-east`, `eu-gb`, `eu-de`, `jp-tok`, `au-syd`

## Input Variables

### Required Variables

| Name | Description | Type |
|------|-------------|------|
| `ibmcloud_api_key` | IBM Cloud API key | `string` |
| `resource_group_id` OR `resource_group_name` | ID or Name of the resource group (one required) | `string` |
| `vpe_configurations` | List of VPE configurations | `list(object)` |

**Note:** You must provide either `resource_group_id` OR `resource_group_name`. If you provide the name, the module will automatically lookup the ID.

### VPE Configuration Object

Each VPE configuration object supports:

| Field | Description | Type | Required |
|-------|-------------|------|----------|
| `name` | Name of the VPE | `string` | Yes |
| `vpc_id` | VPC ID where VPE will be created | `string` | Yes |
| `subnet_ids` | List of subnet IDs for VPE | `list(string)` | Yes |
| `target_crn` | CRN of the target service | `string` | Yes |
| `security_group_ids` | List of security group IDs | `list(string)` | No |
| `resource_group_id` | Override resource group for this VPE | `string` | No |
| `tags` | Tags specific to this VPE | `list(string)` | No |

### Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `region` | IBM Cloud region | `string` | `"us-south"` |
| `prefix` | Prefix for resource names | `string` | `""` |
| `tags` | Global tags for all resources | `list(string)` | `[]` |

## Outputs

| Name | Description |
|------|-------------|
| `vpe_gateways` | Map of all VPE gateway details |
| `vpe_gateway_ids` | List of VPE gateway IDs |
| `vpe_gateway_names` | List of VPE gateway names |
| `vpe_gateway_crns` | List of VPE gateway CRNs |
| `vpe_reserved_ips` | Map of reserved IPs for each VPE |
| `vpe_ip_addresses` | List of all VPE IP addresses |
| `vpe_gateway_ips` | Map of VPE gateway IP bindings |
| `vpe_summary` | Summary of all created VPE resources |

## How to Get Required Information

### VPC ID
```bash
ibmcloud is vpcs --output json | jq -r '.[] | "\(.name): \(.id)"'
```

### Subnet IDs
```bash
ibmcloud is subnets --output json | jq -r '.[] | "\(.name): \(.id) (Zone: \(.zone.name))"'
```

### Resource Group ID
```bash
ibmcloud resource groups --output json | jq -r '.[] | "\(.name): \(.id)"'
```

### Service CRNs
For custom services not in the pre-configured list, you can find CRNs in the IBM Cloud console or use:
```bash
ibmcloud resource service-instances --service-name <service-name> --output json
```

## Deployment Steps

1. **Clone or copy this module to your project**

2. **Create a `terraform.tfvars` file** (see [`terraform.tfvars.example`](./terraform.tfvars.example))

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

4. **Review the plan**
   ```bash
   terraform plan
   ```

5. **Apply the configuration**
   ```bash
   terraform apply
   ```

6. **View outputs**
   ```bash
   terraform output
   ```

## Architecture

This module creates the following resources for each VPE configuration:

1. **Virtual Private Endpoint Gateway** - The main VPE resource
2. **Reserved IPs** - One per subnet specified
3. **Gateway IP Bindings** - Links reserved IPs to the VPE gateway

```
┌─────────────────────────────────────────────────────────┐
│                         VPC                              │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Subnet 1   │  │   Subnet 2   │  │   Subnet 3   │  │
│  │              │  │              │  │              │  │
│  │  Reserved IP │  │  Reserved IP │  │  Reserved IP │  │
│  │  10.240.0.5  │  │  10.240.1.5  │  │  10.240.2.5  │  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  │
│         │                 │                 │           │
│         └─────────────────┼─────────────────┘           │
│                           │                             │
│                  ┌────────▼────────┐                    │
│                  │   VPE Gateway   │                    │
│                  └────────┬────────┘                    │
└───────────────────────────┼─────────────────────────────┘
                            │
                            │ Private Connection
                            │
                   ┌────────▼────────┐
                   │  IBM Cloud      │
                   │  Service        │
                   │  (COS, KMS,     │
                   │   Database...)  │
                   └─────────────────┘
```

## Best Practices

1. **Multi-Zone Deployment**: Deploy VPEs across multiple subnets in different zones for high availability
2. **Security Groups**: Apply appropriate security groups to control traffic to VPE endpoints
3. **Naming Convention**: Use consistent naming with the `prefix` variable
4. **Tagging**: Apply tags for cost tracking and resource management
5. **Resource Groups**: Organize VPEs by environment or application using resource groups

## Troubleshooting

### VPE Creation Fails
- Verify VPC and subnet IDs are correct
- Ensure the target service CRN is valid for your region
- Check that you have appropriate IAM permissions

### Cannot Connect to Service
- Verify security group rules allow traffic
- Check that DNS resolution is working in your VPC
- Ensure the service endpoint is available in your region

### Reserved IP Conflicts
- Ensure subnets have available IP addresses
- Check for IP address conflicts with existing resources

## Examples

See the [`examples/`](./examples/) directory for more detailed examples:
- Single VPE deployment
- Multi-region VPE deployment
- VPE with custom security groups
- Integration with existing VPC module

## License

This module is provided as-is for use with IBM Cloud.

## Contributing

Contributions are welcome! Please submit issues and pull requests.

## Support

For issues related to:
- **This module**: Open an issue in this repository
- **IBM Cloud VPE service**: Contact IBM Cloud Support
- **Terraform IBM Provider**: See [IBM Cloud Terraform Provider documentation](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)

## References

- [IBM Cloud VPC Virtual Private Endpoints](https://cloud.ibm.com/docs/vpc?topic=vpc-about-vpe)
- [IBM Cloud Terraform Provider - VPE Gateway](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_virtual_endpoint_gateway)
- [IBM Cloud Service Endpoints](https://cloud.ibm.com/docs/account?topic=account-service-endpoints-overview)