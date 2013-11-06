Description
===========

Installs and configures AppNeta [TraceView](www.appneta.com/products/traceview/). The default recipe will set up the TraceView API key, Oboe instrumentation libraries, and Tracelyzer monitoring agent. Optionally, it can also be used to install and configure other TraceView instrumentation points (Apache module, PHP extension, Python module, ...).

Requirements
============

TraceView
-----------

Sign up for a [TraceView](www.appneta.com/products/traceview/) account. The API key displayed on the 'Get Started' page is used for provisioning all hosts in a given account.

Platform
--------

* Debian, Ubuntu

Tested on Ubuntu 10.04.3 LTS (Lucid) and 12.04.1 LTS (Precise).

* CentOS, RHEL, and Fedora

Tested on CentOS 6. RHEL and Fedora are not currently tested but should work with the same components as CentOS.

Cookbooks
---------

* [apt](https://github.com/opscode-cookbooks/apt) is only required if you are on a Debian-like system.
* [apache2](https://github.com/opscode-cookbooks/apache2) is only required if you are using the `traceview::apache` recipe.
* [python](https://github.com/opscode-cookbooks/python) is only required if you are using the `traceview::python` recipe.
* [yum](https://github.com/opscode-cookbooks/yum) is only required if you are on a Red Hat-like system.

Attributes
==========

default
-------

* `node['traceview']['access_key']` **required** Your TraceView API key.

apache
------
* `node['traceview']['apache']['appname']` **optional** TraceView application where a node's Apache layers will be assigned to.
* `node['traceview']['apache']['trace_mode']` **optional** Sets when traces should be initiated. Valid values are `always`, `through`, and `never`. Defaults to `always`. [More](https://support.tv.appneta.com/solution/categories/89581/folders/146754/articles/86398-configuring-apache)
* `node['traceview']['apache']['sampling_rate']` **optional** The number of requests out of every million that will be traced. Modifying this value is not recommended for most use cases. [More](https://support.tv.appneta.com/solution/categories/89581/folders/146754/articles/86398-configuring-apache)

php
---
* `node['traceview']['php']['appname']` *optional* TraceView application where a node's PHP layers will be assigned to.
* `node['traceview']['php']['tracing']` *optional* Sets when traces should be initiated. Valid values are `always`, `through`, and `never`. Defaults to `through`. [More](https://support.tv.appneta.com/solution/categories/89581/folders/146755/articles/142080-configuring-php-instrumentation)
* `node['traceview']['php']['sample_rate']` *optional* The number of requests out of every million that will be traced. Modifying this value is not recommended for most use cases. [More](https://support.tv.appneta.com/solution/categories/89581/folders/146755/articles/142080-configuring-php-instrumentation)
* `node['traceview']['php']['enable_sanitize_sql']` *optional* Enable or disable sanitization (via query fingerprinting) of SQL queries in TraceView. Sanitization is disabled by default. [More](https://support.tv.appneta.com/solution/categories/89581/folders/146755/articles/142080-configuring-php-instrumentation)
* `node['traceview']['php']['enable_wrap_error_log']` *optional* By setting this value to 0, you will prevent error_log messages from showing up on our Errors page, improving the signal-to-noise ratio. The default value is 1 (ie. enabled). [More](https://support.tv.appneta.com/solution/categories/89581/folders/146755/articles/142080-configuring-php-instrumentation)

Recipes
=======

default
-------

Includes the `traceview::apt` recipe (or `traceview::yum` as appropriate), configures your `/etc/tracelytics.conf`, and installs the `liboboe0`, `liboboe-dev`, `tracelyzer` packages.

apache
------

Installs `libapache2-mod-oboe` and configures your `/etc/apache2/mods-available/oboe.conf`.

Requires the `apache2` cookbook (not a dependency of this cookbook).

php
---

Installs `php-oboe` and configures `/etc/php5/conf.d/oboe.ini`.

apt
---

Configures the TraceView repository and installs the packaging key for apt based systems.

python
------

Uses `pip` to install the `oboe` Python package.

Requires the `python` cookbook (not a dependency of this cookbook).

yum
---

Configures the TraceView repository and installs the packaging key for yum based systems.
