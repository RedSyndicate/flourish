terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "web" {
  name = "${var.container_name}-web"
}

resource "docker_image" "server" {
  name = "${var.container_name}-api"
}

resource "docker_container" "web" {
  image = docker_image.web.image_id
  name  = "${var.container_name}-web"

  ports {
    internal = 3000
    external = 8080
  }
}

resource "docker_container" "server" {
  image = docker_image.server.image_id
  name  = "${var.container_name}-api"

  ports {
    internal = 5000
    external = 8081
  }
}