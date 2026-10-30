server {
    listen {{ .port }} default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

    location /api {
        proxy_pass http://backend{{ .entry }}/api;
    }

    location /fw {
        proxy_pass http://backend{{ .entry }}/fw;
    }

    location /fw/hcu {
        proxy_pass http://backend{{ .entry }}/fw/hcu;
    }

    # JSON API for Home Assistant (GET state, POST setpoint/pause)
    location /thermostat {
        proxy_pass http://backend{{ .entry }}/thermostat;
    }

}
