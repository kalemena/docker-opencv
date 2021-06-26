FROM ubuntu:20.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena OpenCV" \
      org.label-schema.description="Kalemena OpenCV" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-opencv" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update -y; \
    apt-get upgrade -y; \
	apt-get install -y cmake git python3-pip python3-opencv; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN pip3 --no-cache-dir install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib;
RUN pip3 --no-cache-dir install pillow jupyterlab tensorflow;

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

RUN jupyter notebook --generate-config --allow-root; \
    echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

ADD [ "bootstrap.sh", "/"]

CMD [ "/bin/bash", "bootstrap.sh" ]