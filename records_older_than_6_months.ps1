$today = (Get-Date)
$outdated = $today.Date.AddDays(-2000)
$6months = $today.Date.AddDays(-180)

$records = (Get-DnsServerResourceRecord -zonename st.com -computername <DCNAME> | Where-Object { if($_.Timestamp){[DateTime]$_.Timestamp -ge $outdated -and [DateTime]$_.Timestamp -lt $6months} else{$null} }) 

$records | Export-Clixml oldDNSrecords.xml

$records.hostname > Hostnames_old_DNS_records.txt
