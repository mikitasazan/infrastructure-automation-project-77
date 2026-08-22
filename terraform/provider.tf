provider "aws" {
    region = "eu-central-1"
}
provider "cloudinit" {}

provider "datadog" {
    api_key = var.datadog_api_key
    app_key = var.datadog_app_key
    api_url = "https://app.datadoghq.eu"
}
