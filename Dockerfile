FROM debian:jessie
MAINTAINER Yu XiaoRui <yxiaorui2012@gmail.com>
RUN (echo "deb http://mirrors.ustc.edu.cn/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://mirrors.ustc.edu.cn/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://mirrors.ustc.edu.cn/debian-security/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update && apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git python python-dev python-setuptools nginx sqlite3 supervisor libmysqld-dev libjpeg8-dev
RUN easy_install pip
RUN pip install uwsgi
RUN pip install mysql

ADD . /opt/django/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /opt/django/django.conf /etc/nginx/sites-enabled/
RUN ln -s /opt/django/supervisord.conf /etc/supervisor/conf.d/

RUN pip install -r /opt/django/app/requirements.txt
RUN pip install git+https://github.com/sshwsfc/django-xadmin@django1.8
RUN pip install git+https://github.com/django/django@1.8.7
RUN pip install git+https://github.com/hwbuluo/django-send-messages.git

RUN apt-get clean
RUN rm -rf /var/tmp

VOLUME ["/opt/django/app"]
EXPOSE 80
CMD ["/opt/django/run.sh"]
