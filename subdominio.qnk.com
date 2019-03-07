upstream subdominio.qnk.com {  
  server 127.0.0.1:3000;
}

server {  
  listen 0.0.0.0:80;
  server_name subdominio.qnk.com;
  access_log /var/log/nginx/subdominio.qnk.access.log;
  error_log /var/log/nginx/subdominio.qnk.error.log debug;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarder-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;

    proxy_pass http://127.0.0.1:3000;
    proxy_redirect off;
  }
}