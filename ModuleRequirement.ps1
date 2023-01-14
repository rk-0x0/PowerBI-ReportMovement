
# Install or Update Power BI Management module
if (Get-Module -ListAvailable -Name MicrosoftPowerBIMgmt) {
    Update-Module -Name MicrosoftPowerBIMgmt
} 
else {
    Install-Module -Name MicrosoftPowerBIMgmt
}