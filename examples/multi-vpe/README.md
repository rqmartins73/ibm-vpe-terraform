# Multi-VPE Example

This example demonstrates how to create multiple Virtual Private Endpoints (VPEs) for different IBM Cloud services within the same VPC.

## Overview

This example creates VPEs for:
- **Cloud Object Storage (COS)** - Multi-zone deployment across 3 subnets
- **Key Protect (KMS)** - Single subnet deployment
- **Databases for PostgreSQL** - Single subnet deployment
- **Container Registry** - Multi-zone deployment across 2 subnets

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                           VPC                                │
│                                                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ Subnet 1 │  │ Subnet 2 │  │ Subnet 3 │  │ Subnet 4 │   │
│  │ Zone 1   │  │ Zone 2   │  │ Zone 3   │  │ Zone 1   │   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘   │
│       │             │             │             │           │
│  ┌────▼─────────────▼─────────────▼────┐   ┌────▼─────┐   │
│  │      COS VPE (Multi-Zone)           │   │ KMS VPE  │   │
│  └─────────────────────────────────────┘   └──────────┘   │
│                                                              │
│  ┌──────────────┐  ┌────────────────────────────────┐     │
│  │ Database VPE │  │ Registry VPE (Multi-Zone)      │     │
│  └──────────────┘  └────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## Prerequisites

- IBM Cloud account with appropriate permissions
- Existing VPC with multiple subnets across different zones
- IBM Cloud API key
- Optional: Security groups for controlling VPE traffic

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:
   ```hcl
   ibmcloud_api_key  = "your-api-key"
   region            = "us-south"
   resource_group_id = "your-resource-group-id"
   vpc_id            = "your-vpc-id"
   
   # Subnet IDs for each service
   cos_subnet_ids      = ["subnet-zone1", "subnet-zone2", "subnet-zone3"]
   kms_subnet_id       = "subnet-zone1"
   database_subnet_id  = "subnet-zone2"
   registry_subnet_ids = ["subnet-zone1", "subnet-zone2"]
   
   # Optional security groups
   security_group_ids = ["sg-id-1", "sg-id-2"]
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

## Getting Required IDs

### VPC ID
```bash
ibmcloud is vpcs --output json | jq -r '.[] | "\(.name): \(.id)"'
```

### Subnet IDs (grouped by zone)
```bash
ibmcloud is subnets --output json | jq -r '.[] | "\(.name): \(.id) (Zone: \(.zone.name))"'
```

### Security Group IDs
```bash
ibmcloud is security-groups --output json | jq -r '.[] | "\(.name): \(.id)"'
```

### Resource Group ID
```bash
ibmcloud resource groups --output json | jq -r '.[] | "\(.name): \(.id)"'
```

## Outputs

After successful deployment, you'll see:
- `vpe_gateways` - Complete details of all VPE gateways
- `vpe_gateway_ids` - List of all VPE gateway IDs
- `vpe_gateway_names` - List of all VPE gateway names
- `vpe_ip_addresses` - All private IP addresses assigned to VPEs
- `cos_vpe_details` - Specific details for COS VPE
- `kms_vpe_details` - Specific details for KMS VPE
- `database_vpe_details` - Specific details for Database VPE
- `registry_vpe_details` - Specific details for Registry VPE

## Best Practices Demonstrated

1. **Multi-Zone Deployment**: COS and Registry VPEs span multiple zones for high availability
2. **Service Segregation**: Each service has its own VPE for better isolation
3. **Security Groups**: Optional security groups can be applied to control traffic
4. **Consistent Naming**: All VPEs use a common prefix for easy identification
5. **Comprehensive Tagging**: Tags help with cost tracking and resource management

## Clean Up

To destroy all resources:
```bash
terraform destroy
```

## Notes

- Ensure your subnets are in different availability zones for true high availability
- Security groups should allow traffic on the appropriate ports for each service
- VPE creation may take a few minutes to complete
- All VPEs will be created in the same resource group unless overridden