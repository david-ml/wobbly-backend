#!/bin/bash

python /code/deploy/manage.py migrate
python /code/deploy/manage.py collectstatic --noinput
python /code/deploy/manage.py runserver 0.0.0.0:8080
