# DOCKER IMAGE
FROM python:3.9-alpine3.13 
LABEL maintainer="testprojecthubspot.com"

# you dont want to buffer the output - printing to console
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
# add a copy line for dev
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
  /py/bin/pip install --upgrade pip && \
  /py/bin/pip install -r /tmp/requirements.txt && \
  # add a line if DEV=TRUE
  if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
  fi && \
  rm -rf /tmp && \
  adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user
