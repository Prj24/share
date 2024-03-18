FROM postgres:16.2
LABEL maintainer="Sergei Il <ilsa@glavapu.mos.ru>"

RUN apt update && apt -y upgrade && apt install -y locales

# Locale
RUN sed -i -e \
  's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
   && locale-gen

ENV LANG ru_RU.utf8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

# +Timezone (если надо на этапе сборки)
ENV TZ Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# wget не используется в контейнере
# RUN apt -y install wget

# EXTENSION для PostgreSQL
RUN apt -y install postgresql-16-cron \
 && apt -y install postgresql-16-postgis-3 \
 && apt -y install postgis \
 && apt -y install postgresql-16-pgrouting \
 && apt -y install osm2pgsql \
 && apt -y install postgresql-plpython3-16 \
 && apt -y install postgresql-16-ogr-fdw \
 && apt -y install gdal-bin

# INSTALL CRON, NANO
RUN apt update \
 && apt -y install cron \
 && apt -y install nano