vcl 4.0;

backend default {
    .host = "127.0.0.1";
    .port = "3000";
}

sub vcl_recv {
    if (req.method == "PURGE") {
        return (purge);
    }

    # only on GET requests...
    if(req.method == "GET" || req.method == "HEAD") {
        # Session cookies start with an _. For *this app*, we don't care about the user's session
        # on GET requests, so we can go ahead and remove all cookies begining with _.
        set req.http.Cookie = regsuball(req.http.Cookie, "(^|;\s*)_[^;=]+=[^;]*", "");
    }

    if (req.http.Cookie == "") {
        unset req.http.Cookie;
    }
}

sub vcl_backend_response {
    # If the backend says it's cacheable, we'll remove the cookies, so that the
    # responses hash the same way
    if (beresp.http.Cache-Control ~ "public") {
        set beresp.ttl = 15m;
        unset beresp.http.Set-Cookie;
        set beresp.http.x-mark-for-age-reset = "yes";
    }
}

sub vcl_deliver {
    if (resp.http.x-mark-for-age-reset) {
      # Items we want cached on the front-end need their age reset
      set resp.http.Cache-Control = "private, max-age=60";
      unset resp.http.x-mark-for-age-reset;

      set resp.http.X-Age = resp.http.Age;
      set resp.http.Age = "0";
    } else {
      set resp.http.Cache-Control = "private";
    }
}
