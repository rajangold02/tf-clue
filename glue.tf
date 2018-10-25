resource "aws_glue_crawler" "example" {
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
  name          = "example"
  role          = "${aws_iam_role_policy.glue_service_s3.id}"

  s3_target {
    path = "s3://${aws_s3_bucket.source.bucket}"
  }
}

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "MyCatalogDatabase"
}