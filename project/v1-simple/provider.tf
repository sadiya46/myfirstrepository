provider "aws" {
  region     = var.region
  access_key = "YOUR ACCESS_KEY"
  secret_key = "YOUR SECRET_KEY"
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}
