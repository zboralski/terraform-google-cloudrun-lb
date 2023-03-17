# resources.tf

resource "google_compute_global_address" "service-lb-ip" {
  description = "Global IP address for the load balancer."
  name        = "${var.name}-lb-ip"
  project     = var.project
}

resource "google_compute_region_network_endpoint_group" "service-neg" {
  description           = "Serverless network endpoint group for Cloud Run service."
  name                  = "${var.name}-service-neg"
  project               = var.project
  network_endpoint_type = "SERVERLESS"
  region                = var.location
  cloud_run {
    service = var.service
  }
}


resource "google_compute_security_policy" "security-policy" {
  description = "Security policy to restrict access to authorized IPs."
  name        = "${var.name}-security"
  project     = var.project

  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.authorized_ip_ranges
      }
    }
    description = "Allow access to authorized IPs only"
  }

  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default deny rule"
  }
}
