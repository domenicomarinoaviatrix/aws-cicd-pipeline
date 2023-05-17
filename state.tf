terraform{
    backend "s3" {
        bucket = "aws-cicd-pipeline-niko"
        encrypt = true
        key = "terraform.tfstate"
        region = "eu-west-1"
    }
}

provider "aws" {
    region = "eu-west-1"
}