Function Head {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [scriptblock]
        $InnerHtml
    )
    Tag "head" -TagType ([TagType]::Head) -ParentTags ([TagType]::Html) $InnerHtml
}