build {
  sources = [
    "source.vsphere-iso.main",
  ]

  // Scripts to bootstrap the operating system, so we can use Ansible to configure it.
  provisioner "shell" {
    scripts = [
      "${path.root}/scripts/bootstrap/bootstrap.sh",
    ]
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
  }

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    user = var.ssh_username
    extra_arguments = [
      "--extra-vars",
      "username=\"${var.packer_username}\" password=\"${var.packer_password }\"",
    ]
  }

  post-processors {
    post-processor "manifest" {
      output      = "manifest.json"
      strip_path  = true
    }
  }
}