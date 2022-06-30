terraform {
  backend "s3" {}

  required_providers {
    vercel = {
      source  = "registry.terraform.io/vercel/vercel"
      version = "~> 0.3"
    }

    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "3.2.0"
    }
  }
}

data "vercel_project_directory" "app" {
  path = var.dream_project_dir
}

resource "random_pet" "app_name" {}

resource "vercel_project" "app" {
  name      = random_pet.app_name.id
  framework = "nextjs"
}

resource "vercel_deployment" "app" {
  project_id  = vercel_project.app.id
  files       = data.vercel_project_directory.app.files
  path_prefix = var.dream_project_dir
  production  = true
  environment = var.dream_env
}

output "URL" {
  value = "https://${vercel_deployment.app.url}"
}
