locals {
  timestamp = formatdate("EEE, DD MMM YYYY hh:mm:ss ZZZ", timestamp())
  suffix = formatdate("YYYYMMDD'T'hhmm", timestamp())
  vm_name = "FreeBSD-11.3-amd64-${local.suffix}"
  iso_path = join("", [var.iso_path_prefix, var.iso_path])
  boot_commands = <<-EOT
    <enter><wait10><wait10>
    <tab><enter><wait>
    ifconfig<enter><wait>
    mkdir /tmp/etc<enter><wait>
    mount -t unionfs /tmp/etc /etc<enter><wait>
    rm /etc/resolv.conf<enter><wait>
    dhclient -p /tmp/dhclient.pid -l /tmp/dhclient.lease vmx0<enter><wait10>
    fetch -o /tmp/installerconfig http://{{ .HTTPIP }}:{{ .HTTPPort }}/installerconfig<enter><wait10>
    bsdinstall script /tmp/installerconfig<enter>
    <wait10><wait10>
    EOT
}