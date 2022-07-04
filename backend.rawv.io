# if https, 301(redirect) to https
server {
    listen      80;
    server_name backend.rawv.io;
    return 301 https://$server_name$request_uri;
}

# https listener (443), http2 support
server {
    listen 443 ssl http2;
    server_name backend.rawv.io;
    ssl_certificate      /home/rv/Apps/ssl/App.crt;
    ssl_certificate_key  /home/rv/Apps/ssl/App.key;

    location /favicon.ico {
	    proxy_pass https://img.icons8.com/material-outlined/24/000000/infinity.png;
    }

    location / {
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-NginX-Proxy true;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://localhost:9000;
  }
}
