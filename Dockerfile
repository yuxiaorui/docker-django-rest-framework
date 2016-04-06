FROM debian:jessie
MAINTAINER Yu XiaoRui <yxiaorui2012@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive set -x \
	&& buildDeps=' \
		build-essential \
		git \
		python \
		python-dev \
		python-setuptools \
		nginx \
		sqlite3 \
		supervisor \
		libmysqld-dev \
		libjpeg62-turbo-dev \
		libfreetype6-dev 
		libxft-dev \
		libjpeg62 \
		libjpeg-dev \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN easy_install pip
RUN pip install uwsgi
	&& pip install mysql

ADD . /opt/django/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /opt/django/django.conf /etc/nginx/sites-enabled/
RUN ln -s /opt/django/supervisord.conf /etc/supervisor/conf.d/

RUN pip install git+https://github.com/sshwsfc/django-xadmin@django1.8
RUN pip install git+https://github.com/django/django@1.8.7
RUN pip install git+https://github.com/hwbuluo/django-send-messages.git
RUN pip install -r /opt/django/app/requirements.txt

RUN apt-get clean
RUN rm -rf /var/tmp

VOLUME ["/opt/django/app"]
EXPOSE 80
CMD ["/opt/django/run.sh"]
