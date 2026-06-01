# Provider de AWS. El perfil y la region se toman de variables para poder
# usar tu perfil local de AWS (ej. `aws configure --profile ...`).
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  # Etiquetas por defecto aplicadas a TODOS los recursos del provider.
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
