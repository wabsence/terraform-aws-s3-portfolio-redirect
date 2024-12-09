
# Superheroes Inc. Portfolio Website Deployment on AWS S3

## Project Overview
This project involves the deployment of a portfolio website for **Superheroes Inc.** leveraging Amazon Web Services (AWS) services, primarily utilizing Terraform for infrastructure as code. The website is hosted on an Amazon S3 bucket, and a subdomain (`www.superheroesinc.com.ng`) is configured to redirect to the actual S3 bucket endpoint seamlessly.

## Project Components
1. **AWS S3 Bucket for Main Website**:
   - Hosts the main website content (`index.html`, `error.html`, images like `profile.jpg`, `terraform.jpg`, etc.).
   - Configured with public access policies to allow GET requests from any origin, making the content accessible to all.
   - Website configured with `index.html` as the homepage and `error.html` for error pages.

2. **Redirect S3 Bucket for Subdomain**:
   - Contains the configuration to redirect all requests from `www.superheroesinc.com.ng` to the main website's S3 bucket endpoint.
   - This setup ensures users accessing the subdomain experience a seamless redirection without revealing the S3 endpoint.

3. **Terraform Code**:
   - Automates the creation and configuration of the S3 buckets, public access policies, and website configurations using Terraform.
   - Utilizes resources like `aws_s3_bucket`, `aws_s3_bucket_public_access_block`, `aws_s3_bucket_policy`, and `aws_s3_bucket_website_configuration`.

## Terraform Resources
The Terraform code provided in this project manages the following resources:
- **Main S3 Bucket**:
  - `aws_s3_bucket.mybucket` for hosting the static content.
  - `aws_s3_bucket_public_access_block.mybucket_public_access` to disable public access by default.
  - `aws_s3_bucket_policy.public_policy` to allow GET requests from any origin.
  - `aws_s3_bucket_website_configuration.main_bucket_website` for setting up index and error documents.
- **Redirect S3 Bucket**:
  - `aws_s3_bucket.redirect_bucket` for configuring the subdomain redirection.
  - `aws_s3_bucket_public_access_block.redirect_public_access` to disable public access.
  - `aws_s3_bucket_policy.redirect_policy` to allow GET requests from any origin.
  - `aws_s3_bucket_website_configuration.redirect_bucket_website` for redirecting all requests to the main S3 bucket endpoint.

## Setup Instructions
### Prerequisites
- AWS account with necessary permissions.
- Terraform installed on your local machine.
- Appropriate AWS credentials configured for Terraform to access resources.

### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-name>
```

### 2. Configure AWS Credentials
Ensure your AWS credentials are configured correctly for Terraform to interact with AWS resources.
```bash
aws configure
# Enter your AWS access key, secret key, region, and default output format
```

### 3. Edit Terraform Variables (optional)
Modify the `variables.tf` file if you wish to customize the bucket name, region, or other configurations:
```hcl
variable "bucketname" {
  default = "superheroesinc"
}

variable "region" {
  default = "us-east-1"
}
```

### 4. Initialize Terraform
Initialize Terraform in the project directory to download necessary providers.
```bash
terraform init
```

### 5. Plan the Infrastructure
Review the changes Terraform will apply to your AWS account.
```bash
terraform plan
```

### 6. Apply the Terraform Configuration
Deploy the infrastructure to AWS.
```bash
terraform apply
```
- Review the output and confirm to apply the changes.
- Terraform will create the S3 buckets, configure them, and set up the redirection for the subdomain.

### 7. Testing
1. **Access the Subdomain** (`www.superheroesinc.com.ng`):
   - The website should display the portfolio contents from the main S3 bucket.
   - The browser’s address bar should display `www.superheroesinc.com.ng` while under the hood it redirects to the actual S3 endpoint.
   
2. **Check DNS Configuration**:
   - Use `nslookup` or `dig` to verify that the CNAME records and redirection are set up correctly.
   ```bash
   nslookup www.superheroesinc.com.ng
   ```
   - The output should show the S3 endpoint as the resolved IP address.

3. **Browser Cache**:
   - Clear your browser cache to ensure the latest configurations are reflected.
   - Retest to confirm the redirection and portfolio content display correctly.

## Troubleshooting
- **Issue**: The subdomain doesn't redirect to the S3 endpoint.
  - **Solution**: Verify the DNS setup in Route 53 and ensure the CNAME is correctly pointing to the S3 bucket.
- **Issue**: The browser displays the S3 endpoint URL directly.
  - **Solution**: Check if URL masking is enabled in the S3 bucket configuration and clear the browser cache.
- **Issue**: Terraform apply fails with permission errors.
  - **Solution**: Ensure the AWS credentials have the necessary permissions to create and configure S3 buckets and policies.

## Conclusion
This project demonstrates the use of Terraform for automated infrastructure provisioning on AWS, specifically for deploying a static portfolio website hosted on S3. The integration of the subdomain redirection ensures a seamless user experience without exposing the underlying AWS S3 bucket details.
