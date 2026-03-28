# Multi-Region VPE Example

This example demonstrates how to create Virtual Private Endpoints (VPEs) across multiple IBM Cloud regions for disaster recovery, data residency compliance, and global application access.

## Overview

This example creates VPEs in three regions:
- **US-South (Dallas)** - COS and KMS VPEs
- **EU-GB (London)** - COS and KMS VPEs
- **JP-TOK (Tokyo)** - COS and KMS VPEs

Each region has its own VPC and subnets, with VPEs configured to access regional service endpoints.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Multi-Region Setup                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐ │
│  │   US-South VPC   │  │    EU-GB VPC     │  │  JP-TOK VPC  │ │
│  │                  │  │                  │  │              │ │
│  │  ┌────────────┐  │  │  ┌────────────┐  │  │ ┌──────────┐│ │
│  │  │  COS VPE   │  │  │  │  COS VPE   │  │  │ │ COS VPE  ││ │
│  │  └────────────┘  │  │  └────────────┘  │  │ └──────────┘│ │
│  │  ┌────────────┐  │  │  ┌────────────┐  │  │ ┌──────────┐│ │
│  │  │  KMS VPE   │  │  │  │  KMS VPE   │  │  │ │ KMS VPE  ││ │
│  │  └────────────┘  │  │  └────────────┘  │  │ └──────────┘│ │
│  └──────────────────┘  └──────────────────┘  └──────────────┘ │
│           │                     │                     │         │
└───────────┼─────────────────────┼─────────────────────┼─────────┘
            │                     │                     │
            ▼                     ▼                     ▼
    ┌───────────────┐     ┌───────────────┐    ┌──────────────┐
    │ IBM Cloud     │     │ IBM Cloud     │    │ IBM Cloud    │
    │ Services      │     │ Services      │    │ Services     │
    │ (US-South)    │     │ (EU-GB)       │    │ (JP-TOK)     │
    └───────────────┘     └───────────────┘    └──────────────┘
```

## Use Cases

1. **Disaster Recovery**: Maintain VPE connectivity in multiple regions for failover
2. **Data Residency**: Keep data in specific geographic regions for compliance
3. **Global Applications**: Provide low-latency access to services from different regions
4. **Multi-Region Backup**: Access backup services across regions

## Prerequisites

- IBM Cloud account with appropriate permissions
- VPCs created in US-South, EU-GB, and JP-TOK regions
- Subnets in each VPC
- IBM Cloud API key with multi-region access

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values for each region:
   ```hcl
   ibmcloud_api_key  = "your-api-key"
   resource_group_id = "your-resource-group-id"
   
   # US-South
   vpc_id_us_south     = "r006-vpc-id-us-south"
   subnet_ids_us_south = ["subnet-id-1", "subnet-id-2"]
   
   # EU-GB
   vpc_id_eu_gb     = "r018-vpc-id-eu-gb"
   subnet_ids_eu_gb = ["subnet-id-1", "subnet-id-2"]
   
   # JP-TOK
   vpc_id_jp_tok     = "r022-vpc-id-jp-tok"
   subnet_ids_jp_tok = ["subnet-id-1", "subnet-id-2"]
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Getting Required IDs for Each Region

You'll need to switch regions to get the IDs for each region:

### US-South Region
```bash
ibmcloud target -r us-south
ibmcloud is vpcs --output json | jq -r '.[] | "\(.name): \(.id)"'
ibmcloud is subnets --output json | jq -r '.[] | "\(.name): \(.id) (Zone: \(.zone.name))"'
```

### EU-GB Region
```bash
ibmcloud target -r eu-gb
ibmcloud is vpcs --output json | jq -r '.[] | "\(.name): \(.id)"'
ibmcloud is subnets --output json | jq -r '.[] | "\(.name): \(.id) (Zone: \(.zone.name))"'
```

### JP-TOK Region
```bash
ibmcloud target -r jp-tok
ibmcloud is vpcs --output json | jq -r '.[] | "\(.name): \(.id)"'
ibmcloud is subnets --output json | jq -r '.[] | "\(.name): \(.id) (Zone: \(.zone.name))"'
```

### Resource Group ID (same across regions)
```bash
ibmcloud resource groups --output json | jq -r '.[] | "\(.name): \(.id)"'
```

## Outputs

After successful deployment, you'll see:

### Per-Region Outputs
- `us_south_vpe_gateways` - US-South VPE details
- `us_south_vpe_summary` - US-South summary
- `eu_gb_vpe_gateways` - EU-GB VPE details
- `eu_gb_vpe_summary` - EU-GB summary
- `jp_tok_vpe_gateways` - JP-TOK VPE details
- `jp_tok_vpe_summary` - JP-TOK summary

### Combined Output
- `all_regions_summary` - Summary across all regions including:
  - Total VPEs per region
  - VPE names per region
  - Total VPEs across all regions

## Best Practices Demonstrated

1. **Regional Isolation**: Each region has its own module instance
2. **Consistent Naming**: Region prefix helps identify resources
3. **Service Endpoints**: Uses region-specific service endpoints
4. **Centralized Management**: Single Terraform configuration manages all regions
5. **Resource Tagging**: Tags identify region and purpose

## Cost Considerations

- VPE charges apply per gateway per region
- Data transfer charges may apply between regions
- Consider consolidating VPEs where possible to reduce costs

## Scaling

To add more regions:

1. Add a new module block in `main.tf`
2. Add corresponding variables in `variables.tf`
3. Add outputs in `outputs.tf`
4. Update `terraform.tfvars` with new region details

Example for adding EU-DE:
```hcl
module "vpe_eu_de" {
  source = "../../"
  
  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "eu-de"
  resource_group_id = var.resource_group_id
  prefix            = "eu-de"
  
  vpe_configurations = [
    # Your VPE configurations
  ]
}
```

## Clean Up

To destroy all resources across all regions:
```bash
terraform destroy
```

**Note**: This will destroy VPEs in all three regions. If you want to destroy resources in a specific region only, you can use targeted destroy:
```bash
terraform destroy -target=module.vpe_us_south
```

## Troubleshooting

### Region-Specific Issues
- Ensure your API key has access to all regions
- Verify VPC and subnet IDs are correct for each region
- Check that service endpoints are available in each region

### Network Connectivity
- VPEs in different regions are isolated by default
- Use Transit Gateway if you need cross-region VPC connectivity
- Ensure DNS resolution is configured in each VPC

## Notes

- Each region operates independently
- VPE creation may take several minutes per region
- Service availability varies by region - verify services are available before deployment
- Consider using IBM Cloud Transit Gateway for cross-region connectivity if needed