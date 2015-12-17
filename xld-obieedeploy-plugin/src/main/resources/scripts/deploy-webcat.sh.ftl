echo "Deploying ${deployed.file} on ${deployed.container.name}"
${deployed.container.wlstpath} -i ${deployed.container.host.temporaryDirectoryPath}/tmpWebcatLocation/wlstDeployCatalog.py -u ${deployed.container.username} -p ${deployed.container.password} -h ${deployed.container.host.address} -o ${deployed.container.port} -w ${deployed.file.name}
echo "Done"

