echo "Deploying ${deployed.file} on ${deployed.container.name}"
echo "${deployed.container.host.temporaryDirectoryPath}"
cd ${deployed.container.host.temporaryDirectoryPath+ "/tmp"}
${deployed.container.wlstpath} -i ${script} ${deployed.container.username} t3://${deployed.container.host.address}:${deployed.container.port}
echo "Done"

