Kannel - Opensource SMS and WAP Gateway
=============

Docker image for [Kannel SMS Gateway](http://kannel.org/) -- Based on Alpine Linux

# Usage #

### Create the network ###
```
docker network create kannelnet
```
### Run the bearerbox ###

```
docker run --rm -it --name bearerbox \
                    --hostname bearerbox \
                    --network kannelnet \
                    -p 13000:13000 -p 13001:13001 \
                    --volume /opt/conf:/etc \
                    cyrenity/kannel:1.4.5-alpine \
                    bearerbox -v 1 /etc/kannel.conf
```
### Run the smsbox ###
```
docker run --rm -it --name smsbox \
                    --hostname smsbox \
                    --network kannelnet \
                    -p 13013:13013 \
                    --volumes-from bearerbox \
                    cyrenity/kannel:1.4.5-alpine \
                    smsbox -v 1 /etc/kannel.conf  
```

## Kubernetes ##
Check example deployment files for kubernetes in [k8s](k8s) directory

## Notes ##
For your smsbox to be able to connect with the bearerbox, you first need to start the bearerbox. 
