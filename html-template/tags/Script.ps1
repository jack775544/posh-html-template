function Script {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [scriptblock]
        $InnerHtml,

        [Parameter()]
        [hashtable]
        $Attributes = @{},

        [Parameter()]
        [String]
        $Source
    )
    if ($Source) {
        $Attributes.Remove('src')
        $Attributes.Add('src', $Source)
    }
    Tag "script" -Attributes $Attributes -TagType ([TagType]::String) -ParentTags ([TagType]::Body) $InnerHtml -DisableEscaping
}