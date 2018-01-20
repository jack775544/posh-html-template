Function Html {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [scriptblock]
        $InnerHtml
    )
    Tag "html" -TagType ([TagType]::Html) -ParentTags ([TagType]::TopLevel) $InnerHtml
}