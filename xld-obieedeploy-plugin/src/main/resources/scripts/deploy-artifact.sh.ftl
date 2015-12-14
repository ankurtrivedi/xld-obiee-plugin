echo "Deploying ${deployed.file} on ${deployed.container.name}"
${deployed.container.wlstpath} -i /tmpRpdLocation/wlstDeployRPD.py ${deployed.container.username} ${deployed.container.host.address} ${deployed.container.port} ${deployed.container.adminpassword}
echo "Done"

