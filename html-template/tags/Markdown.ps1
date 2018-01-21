Function Markdown {
    Param(
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
    try {
        Get-Command pandoc
    } catch {
        throw("Pandoc is not installed on this system or does not exist in the PATH. Please install pandoc to use the Markdown feature")
    }
    $MarkdownContents = & $InnerHtml
    $Html = ($MarkdownContents | pandoc -f markdown -t html) -join "`n"
    $Inner = {$Html}
    ClassTag "div" -Attributes $Attributes -Class $Class -Id $Id $Inner -DisableEscaping
}