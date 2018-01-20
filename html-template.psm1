Import-Module (Join-Path $PSScriptRoot -ChildPath "html-template" | Join-Path -ChildPath "New-HtmlString.ps1")

Function New-HtmlString {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0)][scriptblock]$Html
    )
    $ErrorActionPreference = "Stop"
    Invoke-HtmlTemplate -Html $Html
}