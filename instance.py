#!/usr/bin/env python
import helper
import time

client = helper.get_client()
servers = client.servers.list()

print "\nServers:"
for server in servers:
    server_info = [server.name, server.id]
    print "\t".join(server_info)
print "\n"

print "Creating instance"
image = client.images.find(name="Ubuntu 14.04")
flavor = client.flavors.find(name="n1.small")
instance = client.servers.create(name="test_instance", image=image, flavor=flavor)

status = instance.status
while status == 'BUILD':
    time.sleep(5)
    instance = client.servers.get(instance.id)
    status = instance.status
print "status: %s" % status

servers = client.servers.list()
for server in servers:
    print "Server: ", server.name, server.id

print "\nDeleting instance"
