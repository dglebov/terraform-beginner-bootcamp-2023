output "bucket_name" {
  description = "Bucket name for out static website hosting"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  value = module.terrahouse_aws.website_endpoint
}