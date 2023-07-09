# lightweight base image to build an image based off of
FROM python:3.9-slim-buster

# setting the current working directory in the container's filesystem
WORKDIR /usr/src/app

# environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 1
ENV TIME_ZONE America/New_York

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc postgresql \
  && apt-get clean

# add/install requirements
COPY ./requirements.txt .
RUN pip3 install -r requirements.txt

# copy files
COPY . .
COPY ./entrypoint.sh .

# run
RUN chmod +x /usr/src/app/entrypoint.sh
