## BUILDING
##   (from project root directory)
##   $ docker build -t ruby-for-pizza-king-ring-the-king .
##
## RUNNING
##   $ docker run -p 3000:3000 ruby-for-pizza-king-ring-the-king
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/bitnami-containers/minideb-extras:jessie-r14-buildpack

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="k93c22q" \
    STACKSMITH_STACK_NAME="Ruby for Pizza-King/ring-the-king" \
    STACKSMITH_STACK_PRIVATE="1"

# Install required system packages
RUN install_packages libc6 libssl1.0.0 zlib1g libreadline6 libncurses5 libtinfo5 libffi6 libxml2-dev zlib1g-dev libxslt1-dev libgmp-dev ghostscript imagemagick libmysqlclient18 libpq5

RUN bitnami-pkg install ruby-2.3.4-0 --checksum 92d6db7a6ba0893334e9d1d46a66a7459df08e151762f87942d6b0f29db0171a

ENV PATH=/opt/bitnami/ruby/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Ruby base template
COPY Gemfile* /app/
WORKDIR /app

RUN bundle install

COPY . /app

CMD ["irb"]
