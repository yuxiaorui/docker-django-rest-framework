yuxiaorui/docker-django-rest-framework
==================

docker image for django (uwsgi) & nginx
based off of mbentley/django-uwsgi-nginx

To pull this image:
`docker pull yuxiaorui/docker-django-rest-framework`

Example usage:
`docker run -p 80 -d -e MODULE=myapp yuxiaorui/docker-django-rest-framework`

You can mount the application volume to run a specific application.  The default volume inside in the container is `/opt/django/app`.  Here is an example:
`docker run -p 80 -d -e MODULE=myapp -v /home/mbentley/myapp:/opt/django/app yuxiaorui/docker-django-rest-framework`

By default, this just runs a default 'welcome to django' project.