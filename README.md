andrewrothstein.loki
=========

![Build Status](https://github.com/andrewrothstein/ansible-loki/actions/workflows/build.yml/badge.svg)

Installs [loki](https://grafana.com/docs/loki/latest/) and related programs.

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.loki
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
