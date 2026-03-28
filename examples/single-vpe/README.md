# Single VPE Example

This example demonstrates how to create a single Virtual Private Endpoint (VPE) for Cloud Object Storage in one subnet.

## Overview

This example creates:
- One VPE gateway for Cloud Object Storage
- One reserved IP in the specified subnet
- Connection to the COS service endpoint

## Prerequisites

- IBM Cloud account with appropriate permissions
- Existing VPC with at least one subnet
- IBM Cloud API key

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
   subnet_id         = "your-subnet-id"
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

### Subnet ID
```bash
ibmcloud is subnets --output json | jq -r '.[] | "\(.name): \(.id) (Zone: \(.zone.name))"'
```

### Resource Group ID
```bash
ibmcloud resource groups --output json | jq -r '.[] | "\(.name): \(.id)"'
```

## Outputs

After successful deployment, you'll see:
- `vpe_gateway_id` - The ID of the created VPE gateway
- `vpe_gateway_name` - The name of the VPE gateway
- `vpe_ip_address` - The private IP address assigned to the VPE
- `vpe_summary` - Complete summary of the VPE configuration

## Clean Up

To destroy the resources:
```bash
terraform destroy