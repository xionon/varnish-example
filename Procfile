web: bundle exec unicorn_rails
varnish: varnishd -F -f config/varnish.vcl -a 0.0.0.0:$VARNISHPORT -s malloc,256m
