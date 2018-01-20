function H1 {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [scriptblock]
        $InnerHtml,

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
    ClassTag "h1" -Attributes $Attributes -Class $Class -Id $Id $InnerHtml
}