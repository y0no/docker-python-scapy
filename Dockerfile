FROM yarara/base:v1
RUN apt-get update && apt-get install -y unzip zlib1g-dev tcpdump
RUN wget --no-check-certificate -O /tmp/python.tgz https://www.python.org/ftp/python/2.6/Python-2.6.tgz
RUN mkdir /tmp/python && tar -C /tmp/python -zxvf /tmp/python.tgz
RUN mkdir /yarara \ 
  && cd /tmp/python/* \
  && echo "zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz" >> Modules/Setup.dist \
  && ./configure --exec-prefix=/yarara BASECFLAGS=-U_FORTIFY_SOURCE \
  && make \
  && make install
RUN rm -Rvf /tmp/python*
RUN cd /tmp && wget http://www.secdev.org/projects/scapy/files/scapy-2.3.1.zip && unzip scapy-2.3.1.zip && cd scapy-2.* && /yarara/bin/python setup.py install

CMD /yarara/bin/python
