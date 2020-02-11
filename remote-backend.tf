terraform {
  backend "remote" {
    hostname        = "app.terraform.io"   #For SaaS use "app.terraform.io"
    organization    = "edvarga"   #Your Org, top-left corner of the TFE UI
    workspaces {
      name = "edvarga-aws-workspace"  #Workspace to connect to (lives within the Org)
    }
  }
}
