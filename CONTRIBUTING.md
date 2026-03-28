# Contributing to IBM VPE Terraform Module

Thank you for your interest in contributing to the IBM Cloud Virtual Private Endpoint (VPE) Terraform Module!

## How to Contribute

### Reporting Issues

If you find a bug or have a suggestion for improvement:

1. Check if the issue already exists in the [Issues](../../issues) section
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Terraform version and IBM Cloud provider version
   - Relevant configuration snippets

### Submitting Changes

1. **Fork the Repository**
   ```bash
   git clone https://github.com/your-username/ibm-vpe-terraform.git
   cd ibm-vpe-terraform
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow the existing code style
   - Update documentation as needed
   - Add examples if introducing new features
   - Test your changes thoroughly

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

5. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Submit a Pull Request**
   - Provide a clear description of the changes
   - Reference any related issues
   - Ensure all tests pass

## Development Guidelines

### Code Style

- Use consistent indentation (2 spaces)
- Follow Terraform best practices
- Use meaningful variable and resource names
- Add comments for complex logic

### Documentation

- Update README.md for new features
- Add examples for new functionality
- Keep variable descriptions clear and concise
- Update CHANGELOG.md with your changes

### Testing

Before submitting:

1. **Format Check**
   ```bash
   terraform fmt -recursive
   ```

2. **Validation**
   ```bash
   terraform init
   terraform validate
   ```

3. **Example Testing**
   Test your changes with at least one example:
   ```bash
   cd examples/single-vpe
   terraform init
   terraform plan
   ```

### Commit Messages

Use clear, descriptive commit messages:
- Start with a verb (Add, Fix, Update, Remove)
- Keep the first line under 50 characters
- Add detailed description if needed

Examples:
```
Add support for custom security groups
Fix VPE IP allocation issue
Update documentation for multi-region setup
```

## Pull Request Process

1. Ensure your code follows the style guidelines
2. Update documentation to reflect changes
3. Add your changes to CHANGELOG.md under "Unreleased"
4. Request review from maintainers
5. Address any feedback promptly

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Respect differing viewpoints

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks
- Publishing others' private information
- Other unprofessional conduct

## Questions?

If you have questions about contributing, feel free to:
- Open an issue for discussion
- Reach out to the maintainers

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (Apache 2.0).

Thank you for contributing! 🎉