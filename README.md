# Dockerized Tor Relay server

A simple Docker container for running a Tor relay server. The container is configured to relay up to 750GB of data (each way) per month.

The container is also configured to listen on port 9001 for the relay traffic, and 9030 for the directory service. Make sure to open these in your firewall.

## Usage

### Minimal usage

Running the relay is super simple.

    $ docker run -d \
        -p :9001:9001 \
        --restart=always \
        --name=torrelay \
        -t vpetersson/torrelay

### Recommended additional flags

#### Give your node a nickname

It recommended that you provide a Nickname. You can do this using the following flag.

    -e 'NICKNAME=MyTorRelay' \

#### Configure contact info

It is also recommended that you provide your contact information. This is mostly used for contact information in case there is something wrong with your node.

    -e 'CONTACTINFO=John Smith <jsmith@example.com>' \

#### Use persistant storage

Since Tor relies on keys on saved keys on disk for establishing trust, it is a good idea to use a volume to store your tor keys on the host (since Docker containers are ephemeral by nature).

You can do this by passing on the following.

    -v '/some/local/path:/home/tor/.tor' \


#### Set a bandwidth limit

The default value in this container is set to 750 GBytes per month (both ways). Depending on your situation, you may want to increase or decrease this using the following flag.

    -e 'ACCOUNTINGMAX=750 GBytes' \

