FROM python:3.7.0-stretch
LABEL "AUTHOR"="Nathan Miller <nmiller217@gmail.com>"
ENV PYTHONUNBUFFERED 1

# create and populate /code
RUN mkdir /code
COPY ./requirements.txt /code
RUN pip install --upgrade pip 
RUN pip install -r /code/requirements.txt
COPY . /code
WORKDIR /code

RUN chmod 777 deploy/docker-entrypoint.sh
CMD deploy/docker-entrypoint.sh
#ENTRYPOINT ["/code/deploy/docker-entrypoint.sh"]