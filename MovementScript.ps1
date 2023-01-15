try
{
   Connect-PowerBIServiceAccount
}
catch
{
    Write-Output "Connection Failure"
    Write-Output $_

    write-host -nonewline "Continue? (Y/N) "
    $response = read-host
    if ( $response -ne "Y" ) { exit }

}

try {
    
    $path = Get-Location
    $DetailsInputfile = $path+"\InputTargetData.csv"    #CSV path of movement details file
    $ReportOutputfile = $path+"\Reports.csv"            #CSV path for report output

    $CreateNewCSV = {} | Select-Object "ReportID","ReportName" | Export-Csv $ReportOutputfile
    $csvfile = Import-Csv $ReportOutputfile

    $Datafile = Import-Csv $DetailsInputfile
    for($i = 0; $i -lt $Datafile.Count; $i++)
    {
        "Moving "+ $Datafile.NewReportName[$i] + " ....."
        # Copy Report from one workspace to another
        $result = Copy-PowerBIReport -Name $Datafile.NewReportName[$i] -Id $Datafile.SourceReportID[$i] -WorkspaceId $Datafile.SourceWorkspaceID[$i] -TargetWorkspaceId $Datafile.TargetWorkspaceID[$i] -TargetDatasetId $Datafile.TargetDatasetID[$i]
        $csvfile.ReportID = $result.Id.ToString()
        $csvfile.ReportName = $result.Name.ToString()
        $csvfile | Export-CSV $ReportOutputfile –Append
    }
}
catch {
    
}
