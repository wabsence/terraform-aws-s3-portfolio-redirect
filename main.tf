# Main S3 Bucket for superheroesinc.com.ng
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
  
}


# Off Block Public Access for Main Bucket
resource "aws_s3_bucket_public_access_block" "mybucket_public_access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Public Access Policy for Main Bucket
resource "aws_s3_bucket_policy" "public_policy" {
  depends_on = [
    aws_s3_bucket_public_access_block.mybucket_public_access,
  ]
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"
      }
    ]
  })
}

# Website Configuration for Main Bucket
resource "aws_s3_bucket_website_configuration" "main_bucket_website" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Redirect Bucket for www.superheroesinc.com.ng
resource "aws_s3_bucket" "redirect_bucket" {
  bucket = "www.${var.bucketname}"
}

# Off Block Public Access for Redirect Bucket
resource "aws_s3_bucket_public_access_block" "redirect_public_access" {
  bucket = aws_s3_bucket.redirect_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



# Public Access Policy for Redirect Bucket
resource "aws_s3_bucket_policy" "redirect_policy" {
  depends_on = [ 
    aws_s3_bucket_public_access_block.redirect_public_access,
    ]
  bucket = aws_s3_bucket.redirect_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.redirect_bucket.id}/*"
      }
    ]
  })
}

# Website Configuration for Redirect Bucket
resource "aws_s3_bucket_website_configuration" "redirect_bucket_website" {
  bucket = aws_s3_bucket.redirect_bucket.id

  redirect_all_requests_to {
    host_name = "${aws_s3_bucket.mybucket.bucket}.s3-website-${var.region}.amazonaws.com"
    protocol  = "http"
  }
}

# Upload Static Website Objects
resource "aws_s3_object" "index" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "index.html"
  source        = "index.html"
  content_type  = "text/html"
}

resource "aws_s3_object" "error" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "error.html"
  source        = "error.html"
  content_type  = "text/html"
}

resource "aws_s3_object" "profile" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "profile.jpg"
  source        = "profile.jpg"
  content_type  = "image/jpeg"
}

resource "aws_s3_object" "terraform-cert" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "terraform.jpg"
  source        = "terraform.jpg"
  content_type  = "image/jpeg"
}

resource "aws_s3_object" "linux-cert" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "linux.jpg"
  source        = "linux.jpg"
  content_type  = "image/jpeg"
}

resource "aws_s3_object" "docker-cert" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "docker.jpg"
  source        = "docker.jpg"
  content_type  = "image/jpeg"
}

resource "aws_s3_object" "kubernetes-cert" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "kubernetes.jpg"
  source        = "kubernetes.jpg"
  content_type  = "image/jpeg"
}

resource "aws_s3_object" "portfoliio" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "portfolio.png"
  source        = "portfolio.png"
  content_type  = "image/png"
}

resource "aws_s3_object" "rentzone" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "rentzone.jpg"
  source        = "rentzone.jpg"
  content_type  = "image/jpeg"
}

resource "aws_s3_object" "terraformlogo" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "terraformlogo.png"
  source        = "terraformlogo.png"
  content_type  = "image/png"
}

resource "aws_s3_object" "awslogo" {
  bucket        = aws_s3_bucket.mybucket.id
  key           = "awslogo.jpg"
  source        = "awslogo.jpg"
  content_type  = "image/jpeg"
}
