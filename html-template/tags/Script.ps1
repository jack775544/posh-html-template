function Script {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ParameterSetName="InnerScript")]
        [scriptblock]
        $InnerHtml,

        [Parameter()]
        [hashtable]
        $Attributes = @{},

        [Parameter(Position = 0, ParameterSetName="SourceScript")]
        [String]
        $Source
    )
    switch ($PSCmdlet.ParameterSetName) {
        "InnerScript" { 
            Tag "script" -Attributes $Attributes -TagType ([TagType]::String) -ParentTags ([TagType]::Body) $InnerHtml
        }
        "SourceScript" {
            if ($Source) {
                $Attributes.Remove('src')
                $Attributes.Add('src', $Source)
            }
            Tag "script" -Attributes $Attributes -TagType ([TagType]::String) -ParentTags ([TagType]::Body) {} -DisableEscaping
        }
        Default {
            Tag "script" -Attributes $Attributes -TagType ([TagType]::String) -ParentTags ([TagType]::Body) {}
        }
    }
}