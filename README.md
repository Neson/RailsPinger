# RailsPinger

A simple Rails app that pings a sequence of URLs and returns the biggest HTTP (error) code for an request.

Can be used by load balancer health check with multiple sites on a node, endpoints availability checking for monitoring services, etc.

## Usage

This app can be configured via environment variables.

It takes each `PING_URL_n` environment variable (`n` can be 1 up to 100) as URLs to ping while receiving an request.

You can set a key (environment variable `PINGER_KEY`) to only proceed requests with the valid key (`/?key=xxxxxxx`), and redirect request to an optional URL (environment variable `REDIRECT_URL`) for other requests.

## Tips

If you need to ping each virtual site on the local machine, you can setup an wild-card domain that points to 127.0.0.1 (e.g. `*.self.example.com → 127.0.0.1`), then add different sub-domains for each virtual site (`site-1.self.example.com`, `site-2.self.example.com`, `site-3.self.example.com`), finally you can set the pinger to ping those domains. As a result, you can make this pinger an endpoint of availability check for all sites running on this machine (node).
