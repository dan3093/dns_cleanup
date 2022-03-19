$Computers_list = (Get-ADComputer -Filter * -Searchbase <distinguishedName>).name
$Computers_list_count = (Get-ADComputer -Filter * -Searchbase <distinguishedName>).count
$Alive = ""
$Dead = ""
$countprogress = 0
$currentTime = Get-Date -format "dd-MM-yyyy HH_mm_ss"

foreach ($cp in $Computers_list)
    {
    $countprogress += 1
    Write-Host "Testing host $countprogress of $computers_list_count : $cp"
    if (Test-Connection $cp -Count 1 -Quiet) {
        Write-Host "Passed The Connection Test `r`n" -ForegroundColor Green
        $Alive += "$cp`r`n"
        }
    else 
        {
        Write-Host "Failed the Connection Test `r`n" -ForegroundColor Red
        $Dead += "$cp`r`n"
        }
    }

$Alive = $Alive.split("`r`n", [StringSplitOptions]::RemoveEmptyEntries)

$Dead = $Dead.split("`r`n", [StringSplitOptions]::RemoveEmptyEntries)

Write-Host $Alive.Count" Hosts Passed the Connection Test"

$Alive > "Alive_Hosts $currentTime.txt"

Write-Host $Dead.Count" Hosts Failed the Connection Test"

$Dead > "Dead_Hosts $currentTime.txt"
