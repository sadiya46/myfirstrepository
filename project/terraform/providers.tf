/**
 *
 *
 * Copyright 2022 Bredec GmbH
 *
 * All rights reserved in Bredec GmbH, authored and generated code (including the
 * selection and arrangement of the source code base regardless of the authorship
 * of individual files), but not including any copyright interest(s) owned by a 
 * third party related to source code or object code authored or generated by
 * non-Bredec personnel. This source code includes Bredec GmbH confidential and/or
 * proprietary information and may include Bredec GmbH trade secrets. Any use
 * disclosure and/or reproduction is prohibited unless authorized in writing.
 *
 *
 */

provider "aws" {
  region     = var.region
  access_key = "YOUR ACCESS KEY"
  secret_key = "YOUR SECRET KEY"
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}

