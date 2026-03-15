variable "tags" {
  type = map(string)
  default = {
    Environment = "production"
    Project     = "workshop-devops-na-nuvem"
  }
}

variable "assume_role" {
  type = object({
    arn        = string
    region     = string
    access_key = string
    secret_key = string
  })

  default = {
    arn        = "arn:aws:iam::000000000000:root"
    region     = "us-east-1"
    access_key = "test"
    secret_key = "test"
  }
}