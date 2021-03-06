import sys
import os
from java.lang import System
import getopt

def usage():
    print "Usage:"
    print "genWlstDeployRPD -u user -p password -h host -o port -r adminpwd"

try:
    opts, args    = getopt.getopt(sys.argv[1:], "u:p:h:o:r:",
                                  ["user=", "password=", "host=", "port=", "adminpwd="])
except getopt.GetoptError, err:
    print str(err)
    usage()
    sys.exit(2)

user        = ''
password    = ''
host        = ''
port        = ''
adminpwd    = ''

for opt, arg in opts:
    if opt == "-u":
        user      = arg
    elif opt == "-p":
        password  = arg
    elif opt == "-h":
        host      = arg
    elif opt == "-o":
        port      = arg
    elif opt == "-r":
        adminpwd  = arg

if user == "":
    print "Missing \"-u user\" parameter."
    usage()
    sys.exit(2)
elif password == "":
    print "Missing \"-p password\" parameter."
    usage()
    sys.exit(2)
elif host == "":
    print "Missing \"-h host\" parameter."
    usage()
    sys.exit(2)
elif port == "":
    print "Missing \"-o port\" parameter."
    usage()
    sys.exit(2)
elif adminpwd == "":
    print "Missing \"-r adminpwd\" parameter."
    usage()
    sys.exit(2)

connect(user, password, host+":"+port)

# Be sure we are in the root
cd('..\..')

print(host + ': Connecting to Domain ...')
try:
    domainCustom()
except:
    print(host + ': Already in domainCustom')

print(host + ': Go to biee admin domain')
cd('oracle.biee.admin')

# go to the server configuration
print host + ': Go to BIDomain.BIInstance.ServerConfiguration MBean'
cd('oracle.biee.admin:type=BIDomain.BIInstance.ServerConfiguration,biInstance=coreapplication,group=Service')

# Lock the System
print(host + ': Calling lock ...')
cd('..')
cd('oracle.biee.admin:type=BIDomain,group=Service')
objs = jarray.array([], java.lang.Object)
strs = jarray.array([], java.lang.String)
try:
    invoke('lock', objs, strs)
except:
    print(host + ': System already locked')

cd('..')
# go to the server configuration
cd('oracle.biee.admin:type=BIDomain.BIInstance.ServerConfiguration,biInstance=coreapplication,group=Service')
print(host + ': Uploading RPD')
params =  jarray.array(['tmpRpdLocation\deploy.rpd',adminpwd],java.lang.Object)
sign =  jarray.array(['java.lang.String', 'java.lang.String'],java.lang.String)
invoke( 'uploadRepository', params, sign)

# Commit the system
print(host + ': Commiting Changes')
cd('..')
cd('oracle.biee.admin:type=BIDomain,group=Service')
objs = jarray.array([], java.lang.Object)
strs = jarray.array([], java.lang.String)
try:
    invoke('commit', objs, strs)
except:
    print(host + ': System not locked')

# Restart the system
print(host + ': Restarting OBIEE processes')

cd('..\..')
cd('oracle.biee.admin')
cd('oracle.biee.admin:type=BIDomain.BIInstance,biInstance=coreapplication,group=Service')

print(host + ': Stopping the BI instance')
params = jarray.array([], java.lang.Object)
signs = jarray.array([], java.lang.String)
invoke('stop', params, signs)

BIServiceStatus = get('ServiceStatus')
print(host + ': BI ServiceStatus ' + BIServiceStatus)

print(host + ': Starting the BI instance')
params = jarray.array([], java.lang.Object)
signs = jarray.array([], java.lang.String)
invoke('start', params, signs)

BIServerStatus = get('ServiceStatus')
print(host + ': BI ServerStatus ' + BIServerStatus)