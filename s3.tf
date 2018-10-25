resource "aws_s3_bucket" "source" {
  bucket = "${var.source_bucket}"
  acl    = "private"

  tags {
    Name        = "${var.env_name}"
    Environment = "${var.env}"
  }
}

data "template_file" "s3_source" {
  template = "${file("${path.module}/s3-bucket-policy.json")}"

  vars {
    s3_source_bucket_arn = "${aws_s3_bucket.source.arn}"
  }
}

data "template_file" "s3_destination" {
  template = "${file("${path.module}/s3-bucket-policy.json")}"

  vars {
    s3_destination_bucket_arn = "${aws_s3_bucket.destination.arn}"
  }
}

resource "aws_s3_bucket_policy" "sourcebucket_policy" {
  bucket = "${aws_s3_bucket.source.id}"
  policy = "${data.template_file.s3_source.rendered}"
}

resource "aws_s3_bucket_policy" "destinationbucket_policy" {
  bucket = "${aws_s3_bucket.source.id}"
  policy = "${data.template_file.s3_destination.rendered}"
}

resource "aws_s3_bucket" "destination" {
  bucket = "{var.destination_bucket}"
  acl    = "private"

  tags {
    Name        = "${var.env_name}"
    Environment = "${var.env}"
  }
}