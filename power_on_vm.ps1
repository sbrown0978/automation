param (
    [Parameter(Mandatory=$true)]
    [string]$dailypoweruptime
)

Disable-AzContextAutosave -Scope Process
$AzureContext = (Connect-AzAccount -Identity ).context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

$VMs = Get-AzVM | Where-Object {$_.Tags.DailyPowerupTime -eq "$dailypoweruptime"}
$VMs | Start-AzVM -Force
Write-Output "Started VMs are $($VMs.Name)"