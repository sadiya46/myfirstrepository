provider "aws" {
  region     = var.region
  access_key = "<ACCESS_KEY>"
  secret_key = "<SECRET_KEY>"
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}
