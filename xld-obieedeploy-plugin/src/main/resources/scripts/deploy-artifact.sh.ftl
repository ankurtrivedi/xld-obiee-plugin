echo "Deploying ${deployed.file} on ${deployed.container.name}"
echo "${deployed.container.host.temporaryDirectoryPath}"
${deployed.container.wlstpath} -i ${deployed.container.host.temporaryDirectoryPath}/tmpRpdLocation/wlstDeployRPD.py -u ${deployed.container.username} -p ${deployed.container.password} -h ${deployed.container.host.address} -o ${deployed.container.port} -r ${deployed.container.adminpassword}
echo "Done"

