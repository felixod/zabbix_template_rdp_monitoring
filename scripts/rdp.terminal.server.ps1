Param(
    [string]$select
)

switch ($select)
{
  'ACTIVE' {
        # Активные пользователи: Domain Name, Username, Computer Name, IP Address
	    Import-Module PSTerminalServices
	    Get-TSSession -State Active -ComputerName localhost | foreach {$_.DomainName, $_.UserName, $_.ClientName, (($_.IPAddress).IPAddressToString), ""}
	}
  'ACTIVENUM' {
	    # Всего активных пользователей
		Import-Module PSTerminalServices
		Get-TSSession -State Active -ComputerName localhost | foreach {$_.UserName} | Measure-Object -Line | select-object Lines | select-object -ExpandProperty Lines
	}
  'INACTIVE' {
		# Неактивные пользователи: Domain Name, Username
		Import-Module PSTerminalServices
		Get-TSSession -State Disconnected -ComputerName localhost | where { $_.SessionID -ne 0 } | foreach {$_.DomainName, $_.UserName, ""}
	}
  'INACTIVENUM' {
		# Всего неактивных пользователей
		Import-Module PSTerminalServices
		Get-TSSession -State Disconnected -ComputerName localhost | where { $_.SessionID -ne 0 } | foreach {$_.UserName} | Measure-Object -Line | select-object Lines | select-object -ExpandProperty Lines
	}
  'DEVICE' {
		# Список имен подключенных комьютеров
		Import-Module PSTerminalServices
		Get-TSSession -State Active -ComputerName localhost | foreach {$_.ClientName}
	}
  'IP' {
		# Список подключенных IP адресов
		Import-Module PSTerminalServices
		Get-TSSession -State Active -ComputerName localhost | foreach {(($_.IPAddress).IPAddressToString)}
	}
}
