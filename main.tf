# main.tf

module "service-loadbalancer" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 7.0.0"
  name    = "${var.name}-service"
  project = var.project

  # Use the pre-allocated global IP address
  address        = google_compute_global_address.service-lb-ip.address
  create_address = false

  # Conditional SSL configuration
  ssl = var.use_ssl
  https_redirect = var.use_ssl

  # Use Google-managed SSL certificates if domains are provided, otherwise use custom SSL certificate
  dynamic "ssl_policy" {
    for_each = length(var.managed_ssl_certificate_domains) > 0 ? [1] : []
    content {
      managed_ssl_certificate_domains = var.managed_ssl_certificate_domains
    }
  }

  # Reference to the custom SSL certificate (assuming the certificate is managed outside this module)
  ssl_certificates = length(var.managed_ssl_certificate_domains) == 0 && var.use_ssl ? [var.ssl_certificate_id] : []

  backends = {
    default = {
      description = "Default backend for the load balancer."
      groups = [
        { group = google_compute_region_network_endpoint_group.service-neg.id }
      ]
      compression_mode        = null
      protocol                = "HTTP"
      port                    = 8080
      port_name               = "http"
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null
      security_policy         = google_compute_security_policy.security-policy.id

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = var.logging_enabled
        sample_rate = var.logging_sample_rate
      }
    }
  }
}
