FROM python:3.7
WORKDIR /app

RUN apt-get update

COPY Pipfile* /app/

RUN pip install uvicorn
RUN pip install uwsgi
RUN pip install pipenv && pipenv install --system --deploy

COPY . /app

ENV DJANGO_ENV=prod
ENV DOCKER_CONTAINER=1

EXPOSE 8000
CMD ["./docker-run.sh"]
