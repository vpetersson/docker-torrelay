# Dockerized Tor Relay Node
#
# VERSION               0.0.1

FROM ubuntu:14.04
MAINTAINER Viktor Petersson "vpetersson@wireload.net"

# Make sure we're up to date
RUN apt-get update
RUN apt-get -y upgrade

# Install Tor
RUN echo 'deb http://deb.torproject.org/torproject.org trusty main' >> /etc/apt/sources.list
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
RUN apt-get update
RUN apt-get -y install tor

# Configure Tor

## Configure the main port
RUN echo 'ORPort 9001' >> /etc/tor/torrc
EXPOSE 9001

## Configure the directory service
RUN echo 'DirPort 9030' >> /etc/tor/torrc
EXPOSE 9030

## Disable Socks connections
RUN echo 'SocksPort 0' >> /etc/tor/torrc

## Reject all exits. Only relay.
RUN echo 'Exitpolicy reject *:*' >> /etc/tor/torrc

## Not so useful information
RUN echo 'Nickname DockerizedTorRelay' >> /etc/tor/torrc
RUN echo 'ContactInfo human@DockerTorRelay.local' >> /etc/tor/torrc

## Start the count on the first after midnight
RUN echo 'AccountingStart month 1 00:01' >> /etc/tor/torrc

## Share 750 Gigabytes per month (each way)
RUN echo 'AccountingMax 750 GBytes' >> /etc/tor/torrc

## Add a user
RUN adduser tor

# Fire up Tor
USER tor
CMD /usr/sbin/tor -f /etc/tor/torrc
