output "bucket_name" {
  description = "Bucket name for out static website hosting"
  value = module.home_fallout_hosting.bucket_name
}

output "s3_website_endpoint" {
  value = module.home_fallout_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_fallout_hosting.domain_name
}