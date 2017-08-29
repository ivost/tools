provider "kubernetes" {
	version = "~> 1.0"
}

resource "kubernetes_pod" "nginx" {
  metadata {
    name = "nginx-example"
    labels {
      App = "nginx"
    }
  }

  spec {
    container {
      image = "nginx:1.7.8"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-example"
  }
  spec {
    selector {
      App = "${kubernetes_pod.nginx.metadata.0.labels.App}"
    }
    port {
      port = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

/*

https://www.terraform.io/docs/providers/kubernetes/guides/getting-started.html

Please note that this assumes a cloud provider provisioning IP-based load balancer (like in Google Cloud Platform). If you run on a provider with hostname-based load balancer (like in Amazon Web Services) you should use the following snippet instead.

*/

output "lb_ip" {
  value = "${kubernetes_service.nginx.load_balancer_ingress.0.hostname}"
}
