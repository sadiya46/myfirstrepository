provider "aws" {
  region     = var.region
  access_key = "AKIAYAO3W5NSFWVPFFX5"
  secret_key = "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"
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}
