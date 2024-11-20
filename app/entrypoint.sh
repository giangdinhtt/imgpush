#!/bin/bash
CORS_HEADERS="${ALLOWED_ORIGINS:-['*']}"
ESCAPED_REPLACE=$(printf '%s\n' "$CORS_HEADERS" | sed -e 's/[]\/$*.^[]/\\&/g');

sed -i "s/\${ALLOWED_ORIGINS}/$ESCAPED_REPLACE/g" /etc/nginx/conf.d/default.conf

nginx
gunicorn --bind unix:imgpush.sock wsgi:app --access-logfile -