{% set cfg = opts.ms_project %}
{% set data = cfg.data %}
{% set scfg = salt['mc_utils.json_dump'](cfg) %}

{{cfg.name}}-www-data:
  user.present:
    - name: www-data
    - optional_groups:
      - {{cfg.group}}
    - remove_groups: false

prepreqs-{{cfg.name}}:
  pkg.installed:
    - watch:
      - user: {{cfg.name}}-www-data
    - pkgs:
      - sqlite3
      - liblcms2-2
      - liblcms2-dev
      - libcairomm-1.0-dev
      - libcairo2-dev
      - libsqlite3-dev
      - apache2-utils
      - autoconf
      - automake
      - build-essential
      - bzip2
      - gettext
      - libpq-dev
      - libmysqlclient-dev
      - git
      - groff
      - libbz2-dev
      - libcurl4-openssl-dev
      - libdb-dev
      - libgdbm-dev
      - libreadline-dev
      - libfreetype6-dev
      - libsigc++-2.0-dev
      - libsqlite0-dev
      - libsqlite3-dev
      - libtiff5
      - libtiff5-dev
      - libwebp5
      - libwebp-dev
      - libssl-dev
      - libtool
      - libxml2-dev
      - libxslt1-dev
      - libopenjpeg-dev
      - libopenjpeg2
      - m4
      - man-db
      - pkg-config
      - poppler-utils
      - python-dev
      - python-imaging
      - python-setuptools
      - tcl8.4
      - tcl8.4-dev
      - tcl8.5
      - tcl8.5-dev
      - tk8.5-dev
      - cython
      - python-numpy
      - zlib1g-dev

{{cfg.name}}-dirs:
  file.directory:
    - makedirs: true
    - user: {{cfg.user}}
    - group: {{cfg.group}}
    - watch:
      - pkg: prepreqs-{{cfg.name}}
      - user: {{cfg.name}}-www-data
    - names:
      - {{cfg.data_root}}/cache
      - {{data.DATA_FOLDER}}

{% for i in ['cache'] %}
{{cfg.name}}-l-dirs-{{i}}:
  file.symlink:
    - watch:
      - file: {{cfg.name}}-dirs
    - name: {{cfg.project_root}}/{{i}}
    - target: {{cfg.data_root}}/{{i}}
{%endfor %}
