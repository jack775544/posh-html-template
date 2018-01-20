function Title {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [scriptblock]
        $InnerHtml = {},

        [Parameter()]
        [hashtable]
        $Attributes = @{}
    )
    Tag "title" -Attributes $Attributes -TagType ([TagType]::String) -ParentTags ([TagType]::Head) $InnerHtml
}