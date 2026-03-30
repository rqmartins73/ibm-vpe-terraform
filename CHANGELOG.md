# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-03-30

### Added
- Support for `resource_group_name` variable as an alternative to `resource_group_id`
- Automatic resource group ID lookup when using `resource_group_name`
- Data source `ibm_resource_group` for name-to-ID resolution
- Validation to ensure either `resource_group_id` or `resource_group_name` is provided

### Changed
- `resource_group_id` is now optional (default: null)
- Updated documentation with examples using both ID and name approaches

### Fixed
- Improved resource group ID handling using `coalesce()` function to prevent null values
- Fixed issue where null `resource_group_id` in VPE configurations caused API errors

## [1.0.0] - 2026-03-28

### Added
- Initial release of IBM Cloud VPE Terraform Module
- Support for creating multiple Virtual Private Endpoints in a single deployment
- Flexible VPE configuration across different VPCs and regions
- Support for multiple subnets per VPE
- Optional security group assignments
- Comprehensive tagging and naming conventions
- Pre-configured service endpoint CRNs for common IBM Cloud services:
  - Cloud Object Storage (COS)
  - Key Protect / HPCS (KMS)
  - Databases for PostgreSQL
  - Container Registry
- Support for major IBM Cloud regions:
  - us-south (Dallas)
  - us-east (Washington DC)
  - eu-gb (London)
  - eu-de (Frankfurt)
  - jp-tok (Tokyo)
  - au-syd (Sydney)
- Comprehensive outputs for integration with other modules
- Three complete examples:
  - Single VPE deployment
  - Multi-VPE deployment (multiple services in one VPC)
  - Multi-region deployment (VPEs across multiple regions)
- Complete documentation:
  - Main README with usage examples
  - Example-specific READMEs
  - Contributing guidelines
  - Apache 2.0 License

### Features
- Automatic reserved IP creation and management
- Gateway IP binding automation
- Flexible resource group assignment per VPE
- Tag merging (global + VPE-specific tags)
- Lifecycle management with tag ignore rules
- Input validation for VPE configurations

### Documentation
- Comprehensive README with architecture diagrams
- Detailed variable descriptions
- Output documentation
- Troubleshooting guide
- Best practices section
- CLI command examples for getting required IDs

## [Unreleased]

### Planned
- Support for additional IBM Cloud services
- Enhanced security group management
- VPE health monitoring integration
- Automated DNS configuration
- Cost estimation examples
- Terraform Cloud/Enterprise integration examples

---

## Version History

### Version Numbering
- **Major version** (X.0.0): Breaking changes
- **Minor version** (0.X.0): New features, backward compatible
- **Patch version** (0.0.X): Bug fixes, backward compatible

### Support
For issues and feature requests, please use the [GitHub Issues](../../issues) page.