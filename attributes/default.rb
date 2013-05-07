# Tracelytics app name; if not set, hostname will not be registered with app
default['tracelytics']['appname'] = nil

#
# PHP instrumentation
#

# Tracelytics PHP layer application name; if not set, PHP layer will not be registered 
# with an app as a starting point for this host
#
# WARNING: do not assign the same appname as other layers
default['tracelytics']['php']['appname'] = nil

# Determines when incoming requests are to be traced. Valid options are "always" 
# (initiate new traces according to the sample_rate below), "through" (add to 
# traces that are initiated higher up the call chain) and "never". 
# Default is "through".
default['tracelytics']['php']['tracing'] = 'through'

# When oboe.tracing is set to always, this value determines the number of 
# requests out of every million that will be traced, and must be an integer 
# between 0 and 1000000. 
# Default is 300000 (ie. 30%).
default['tracelytics']['php']['sample_rate'] = 30000

# Enable or disable sanitizing SQL query traces. The following values are accepted:
# 0 - disable SQL sanitizing (default),
# 1 - enable SQL sanitizing and attempt to automatically determine which quoting form is used,
# 2 - enable SQL sanitizing and drop double quoted characters, or
# 4 - enable SQL sanitizing and retain double quoted characters.
default['tracelytics']['php']['enable_sanitize_sql'] = 0

# Some applications use PHP's error_log() function as an easy way to log 
# debugging and other messages. By setting this value to 0, you will prevent 
# error_log messages from showing up on our Errors page, improving the 
# signal-to-noise ratio. Other, non-error_log PHP errors (such as undefined 
# variables, syntax errors, etc) will still be captured. 
# Default is 1 (ie. enabled).
default['tracelytics']['php']['enable_wrap_error_log'] = 1