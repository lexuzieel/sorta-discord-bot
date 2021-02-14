#
# Base stage is used for both development and production.
# It is used to install application code and its dependencies.
#

FROM python:3.9 AS base

WORKDIR /usr/src/app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1

#
# Production is the next stage since it's the minimal
# required setup in order to launch the application.
#

FROM base AS production

CMD [ "python", "__main__.py" ]

#
# Optionally a development stage can be defined INSTEAD
# of production stage. Here additional dependencies can
# be installed that will make container bigger, which
# is is okay during local development.
#

FROM base AS development

RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -y nodejs

RUN npm i -g nodemon

CMD [ "nodemon", "--exec", "python", "__main__.py" ]
