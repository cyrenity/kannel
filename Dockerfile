FROM amd64/alpine:latest

RUN  apk update \                                                                                                                                                                                                                        
  && apk add wget build-base libxml2-dev bison pcre-dev\                                                                                                                                                                                                      
  && wget --no-check-certificate https://kannel.org/download/1.4.5/gateway-1.4.5.tar.gz \
  && tar xzf gateway-1.4.5.tar.gz \
  && wget --no-check-certificate https://redmine.kannel.org/attachments/download/327/gateway-1.4.5.patch.gz \
  && echo "#include <unistd.h>" > /usr/include/sys/unistd.h \
  && echo "#include <poll.h>" > /usr/include/sys/poll.h \
  && cd gateway-1.4.5 \
  && gunzip -c ../gateway-1.4.5.patch.gz | patch -p1 \
  && ./configure --prefix=/usr --sysconfdir=/etc/kannel  --disable-wap --enable-pcre \
  && touch .depend \
  && make \
  && make install \
  && cp test/fakesmsc /usr/sbin/ \
  && cp test/fakewap /usr/sbin/ \
  && cd .. / \
  && rm gateway-1.4.5.tar.gz \
  && rm gateway-1.4.5.patch.gz \
  && rm -Rf gateway-1.4.5 \
  && mkdir -p /var/log/kannel \
  && mkdir -p /var/spool/kannel \
  && apk del bison wget build-base pcre-dev \
  && apk add pcre

VOLUME /etc/kannel
VOLUME /var/log/kannel
VOLUME /var/spool/kannel

EXPOSE 13000
EXPOSE 13001
EXPOSE 13013

WORKDIR /usr/sbin
