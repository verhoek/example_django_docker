#!/bin/bash

set -e

# Kill server when Bash receives stop signal from Docker or from terminal.
stop_server() {
    kill -SIGTERM $CHILD_PID;
    wait $CHILD_PID;
    exit $?; # Exit with return code from child process
}
trap stop_server SIGINT SIGTERM;

./manage.py migrate
./manage.py collectstatic --no-input

echo "ASGI: $ASGI"

if $ASGI; then
  uvicorn django_project.asgi_wsgi:application --log-level debug --host 0.0.0.0
else
  uwsgi --ini /app/uwsgi.ini
fi
