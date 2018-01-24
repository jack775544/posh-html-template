Import-Module (Join-Path $PSScriptRoot -ChildPath "html-template" | Join-Path -ChildPath "New-HtmlString.ps1")

Function New-HtmlString {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0)][scriptblock]$Html
    )
    Invoke-HtmlTemplate -Html $Html -ErrorAction "Stop"
}