function Body {
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
    if ($Class.Length -ne 0) {
        $Attributes.Remove('class')
        $Attributes.Add('class', $Class -join " ")
    }
    if ($Id) {
        $Attributes.Remove('id')
        $Attributes.Add('id', $Id)
    }
    Tag 'body' -Attributes $Attributes -TagType ([TagType]::Body) -ParentTags ([TagType]::Html) $InnerHtml
}