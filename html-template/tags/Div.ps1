function Div {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [scriptblock]
        $InnerHtml = {},

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
    ClassTag "div" -Attributes $Attributes -Class $Class -Id $Id $InnerHtml
}