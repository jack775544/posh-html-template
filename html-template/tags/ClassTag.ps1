function ClassTag {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)]
        [String]
        $TagName,

        [Parameter(Position = 1, Mandatory = $true)]
        [scriptblock]
        $InnerHtml,

        [Parameter()]
        [String[]]
        $Class,

        [Parameter()]
        [String]
        $Id,

        [Parameter()]
        [hashtable]
        $Attributes = @{},

        [Parameter()]
        [string[]]
        $Properties = @(),

        [Parameter()]
        [TagType]
        $TagType = [TagType]::Body,

        [Parameter()]
        [TagType[]]
        $ParentTags = @([TagType]::Body)
    )
    if ($Class.Length -ne 0) {
        $Attributes.Remove('class')
        $Attributes.Add('class', $Class -join " ")
    }
    if ($Id) {
        $Attributes.Remove('id')
        $Attributes.Add('id', $Id)
    }
    Tag $TagName -Attributes $Attributes -TagType $TagType -ParentTags $ParentTags $InnerHtml
}