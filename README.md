Rackspace cloud monitoring hipchat
==================================

For lack of a better name, here's Rackspace cloud monitoring hipchat, an alarm webhook that you can point your monitors at!

How do you set this up?
=======================
The app has been tested on Ubuntu 12.04 with Brightbox's 1.9 Ruby (https://launchpad.net/~brightbox/+archive/ruby-ng), it's a Sinatra application and the ways to set this up vary from having your own service, to just running `unicorn -c unicorn.rb -E production -D` from within the directory the app is cloned in.

It expects requests go to /alarm, however you will need to set this up and also do any HTTPS / Basic Auth work yourself through a front-end HTTP server, for reference, my nginx setup is fairly straightforward:

```
  upstream cloudmonitoring {
    server unix:/var/www/rackspace-cloud-monitoring-hipchat/tmp/sockets/unicorn.sock;
  }
  
  location /alarm {
    proxy_pass  http://cloudmonitoring;
    proxy_set_header   Host             $host;
    proxy_set_header   X-Real-IP        $remote_addr;
    proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
  }
```

How do you configure the webhook?
=================================

1. Visit https://ui-labs.cloudmonitoring.rackspace.com/#notifications
2. Create a notification of type webhook and name it appropriately, pointing it to wherever you want this to sit
3. Create a notification plan, using the same notification for OK, WARNING and CRITICAL notifications
4. Go back to the cloud control panel and set up your monitoring checks
