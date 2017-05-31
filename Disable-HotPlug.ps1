# A simple script to disable hotplug for VMs on vSphere
# Tested with PowerCLI 6.5.1 on vSphere 6.0u2

Import-Module VMware.PowerCLI

Connect-VIServer -Server "server"

$vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
$optionValue = New-Object VMware.Vim.optionvalue

$optionValue.Key = “devices.hotplug”
$optionValue.Value = “false”
$vmConfigSpec.extraconfig += $optionValue

#Example to get VMs by name with a wildcard
#$vms = Get-VM -Name "VDI*"

#Example to get all VMs on a cluster
#$vms = Get-Cluster -Name "Cluster01" | Get-VM

ForEach ($vm in $vms) {

    $vm.ExtensionData.ReconfigVM($vmConfigSpec)

}

Disconnect-VIServer -Confirm

#Unload the module when complete
Remove-Module VMware.PowerCLI
