FROM	opensuse/leap:latest

LABEL maintainer="Maintainers: <metanoeho@zebulon.nl>"

ENV POSTFIXVERSION  3.3

WORKDIR /


RUN	zypper -n up \
	&& zypper install -y --no-recommends postfix postfix-mysql ca-certificates shadow gpg2 openssl pcre zlib python3-pip nano iputils \
	&& zypper clean -a \
	&& pip install --upgrade pip \
	&& pip install supervisor

# create user and group 'postfix'.
# RUN 	groupadd -g 101 nginx && useradd -d /var/lib/nginx -c 'NGINX http server' -M -u 101 -g 101 nginx \
#	&& usermod -G 100 -a nginx

COPY 	rootfs /

EXPOSE 25 110 143 465 587 993 995 

STOPSIGNAL SIGTERM

CMD ["supervisord" ]
