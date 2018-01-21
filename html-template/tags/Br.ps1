function Br {
    [CmdletBinding()]
    Param (
        [Parameter()]
        [hashtable]
        $Attributes = @{},

        [Parameter()]
        [String[]]
        $Class,

        [Parameter()]
        [String]
        $Id
    )
    ClassTag "br" -Attributes $Attributes -Class $Class -Id $Id {} -SelfClosing
}