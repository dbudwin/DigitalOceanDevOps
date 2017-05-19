server {
    listen 80;
    listen [::]:80;

    server_name example.com;

    location / {
        root /var/www/html/example.com;
        index index.html index.htm;
    }
}