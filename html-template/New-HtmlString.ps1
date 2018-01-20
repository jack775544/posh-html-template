Get-ChildItem (Join-Path $PSScriptRoot -ChildPath "tags") | ForEach-Object {Import-Module $_.FullName}

Class HtmlTag {
    # The name of the html tag
    [string]$TagName
    # The inner html contents of the tag
    [object[]]$InnerHtml
    # The attrs that the tag has
    [hashtable]$Attributes = @{}
    # The standalone properties that the tag has
    [string[]]$Properties = @()
    # Is the tag self closing
    [bool]$SelfClosing = $false
    # What type of tags this tag can contain
    [string]$TagType = $null
    # Is this a custom tag
    [bool]$Custom = $false
    # What can this tag be a child of
    [TagType[]]$ParentTags
    # Does this tag have inner html string escaping disabled
    [bool]$DisableEscaping = $false

    HtmlTag ([string]$TagName, [object[]]$InnerHtml, [hashtable]$Attributes, [string[]]$Properties, [bool]$SelfClosing, [string]$TagType, [bool]$Custom, [TagType[]]$ParentTags) {
        $this.TagName = $TagName
        $this.InnerHtml = $InnerHtml
        $this.Attributes = $Attributes
        $this.Properties = $Properties
        $this.SelfClosing = $SelfClosing
        $this.TagType = $TagType
        $this.Custom = $Custom
        $this.ParentTags = $ParentTags
    }

    HtmlTag () {}
}

Enum TagType {
    String
    TopLevel
    Html
    Head
    Body
}

function Tag {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)]
        [String]
        $TagName,

        [Parameter(Position = 1, Mandatory = $true)]
        [scriptblock]
        $InnerHtml,

        [Parameter()]
        [hashtable]
        $Attributes = @{},

        [Parameter()]
        [string[]]
        $Properties = @(),

        [Parameter()]
        [switch]
        $SelfClosing = $false,

        [Parameter()]
        [TagType]
        $TagType,

        [Parameter()]
        [TagType[]]
        $ParentTags = @(),

        [Parameter()]
        [switch]
        [Alias("Custom")]
        $CustomTag = $false,

        [Parameter()]
        [switch]
        $DisableEscaping = $false
    )
    Write-Verbose "Creating tag of type $TagName with the attrs $($Attributes.GetEnumerator() | ForEach-Object { $_.Key +": " + $_.Value })"
    $Inner = & $InnerHtml
    [HtmlTag]@{
        TagName = $TagName
        InnerHtml = $Inner
        Attributes = $Attributes
        Properties = $Properties
        SelfClosing = $SelfClosing
        TagType = $TagType
        Custom = $Custom
        ParentTags = $ParentTags
        DisableEscaping = $DisableEscaping
    }
}

Function Invoke-HtmlTemplate {
    Param(
        [scriptblock]$Html
    )
    Write-Verbose "Constucting HTML Template"
    $Dom = & $Html
    Write-Verbose "Constructing Html String"
    $Type = [TagType]::TopLevel
    ConvertTo-HtmlString -Tag $Dom -ParentTagType $Type -TagStack @()
}

Function ConvertTo-HtmlString {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)][HtmlTag]$Tag,
        [Parameter(Mandatory = $true, Position = 1)][TagType]$ParentTagType,
        [Parameter(Position = 2)][string[]]$TagStack
    )
    $TagStack += $Tag.TagName
    if ($ParentTagType -eq [TagType]::String) {
        throw("The tag `"$($Tag.TagName)`" is not valid in the context of $ParentTagType. The only valid inner html elements are strings. Tag stack: ($($TagStack -join ' > '))")
    }
    if ($ParentTagType -ne [TagType]::TopLevel) {
        if ($Tag.ParentTags -notcontains $ParentTagType) {
            throw("The Tag `"$($Tag.TagName)`" is not valid in a tag of type $ParentTagType. It is only valid in ($($Tag.ParentTags -join ', ')). Tag stack: ($($TagStack -join ' > '))")
        }
    }
    $TagLine = "<$($Tag.TagName)$($Tag.Attributes.GetEnumerator() | ForEach-Object {' ' + $_.Key + '="' + $_.Value + '"'})$($Tag.Properties | ForEach-Object {" $_"})"
    if ($Tag.SelfClosing) {
        "$TagLine />"
    } else {
        "$TagLine>`n"
        $Tag.InnerHtml | ForEach-Object {
            if ($_ -is [HtmlTag]) {
                "    $(ConvertTo-HtmlString $_ $Tag.TagType $TagStack)`n"
            } else {
                if ($Tag.DisableEscaping) {
                    "    $($_.ToString())"
                } else {
                    "    $(Escape-String -String ($_.ToString()))`n"
                }
            }
        }
        "</$($Tag.TagName)>`n"
    }
}

Function Escape-String {
    Param(
        [string]$String
    )
    $String -replace "&", "&amp" -replace "<", "&lt" -replace ">", "&gt"
}