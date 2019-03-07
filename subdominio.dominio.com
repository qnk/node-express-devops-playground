upstream subdominio.tu_dominio.com {  
  server 127.0.0.1:3000;
}

server {  
  listen 0.0.0.0:80;
  server_name subdominio.dominio.com;
  access_log /var/log/nginx/subdominio.dominio.access.log;
  error_log /var/log/nginx/subdominio.dominio.error.log debug;

  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarder-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;

    proxy_pass http://subdominio.dominio.com;
    proxy_redirect off;
  }
}