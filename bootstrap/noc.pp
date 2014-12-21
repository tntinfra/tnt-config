class noc {
  package { 'git':
    ensure => 'installed',
  }

  ssh_authorized_key { 'tosmi':
    user => 'root',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDw3VG4B9wiSc1UR9igEGxSc66f1BvBVVX3h+e7drwTV5r0sv4hVqymk7UCQYiTsZZiqM2t3VSUyPcG7zi86sgmjpeuZxgXQWj1AiASoNyv4IK0z3PDZtedJJUrK6ztYwPhsIhUrlA6oLTtYJ+e5x78zjJwmIPwMfU0cGlUsRKU+cB0Dnuy9Au9Xq9ZJmiNuerwsAjaaXVaeETW7PAshGov5wxfqlQ7qH2IpMuEeoO5OM1PuRHFaWA+bnjI8HNm+Hv4ARnG9G+GUa5kXGsY6eHZNiarb1pKVMv9k53/iKe+3Y4jWD3q6vODyUiKCix3e72hBGhQuZbMybpY89HF7BJPa9QrIv3b8sb0/dYkrTa/8tFYP/XN6mDegwaVk8IG+1/bDPBIxx0PkYAKg82abGMlOwYGQMbaH7S6E+/yrl5fnM5EVU5LSoOM2OMFnWHmqJDk0bdoHpPI523pgBDmxVJHFMfhGSyEE40SZ/JCjwMOKu1wTtBVoXRiW5aTzpQ4apY8iMCHcm2AQ09P7aoFitK7CFmhUVMfIK6qcY0HWFx6Et6GxPH4K8MT1hnN1uU1R0hXVWIDs51UWT5/G1hxP6A3ogYkn3b0gUA/oTFFPFko7QX8h0qPfDhsw1dOs9k5S4zUkv4kNtZpue/EPvsplJQcwyRJvuq5hkXDvH7+nSJJqw=='
  } 

  file { '/root/.gitconfig':
    ensure => 'file',
    content => "[user]\n  email = tntadmin@tntinfra.net\n  name = TNT Admin\n[push]\n  default = simple\n",
  }
}

include noc
