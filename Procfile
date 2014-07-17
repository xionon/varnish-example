web: bundle exec puma -e $RAILS_ENV -p $PORT -C config/puma.rb
varnish: varnishd -F -f config/varnish.vcl -a 0.0.0.0:$VARNISHPORT -s malloc,256m
