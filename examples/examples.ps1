Remove-Module -ErrorAction SilentlyContinue html-template
Import-Module ..\html-template.psd1

# Example 1
New-HtmlString {
    Html {
        Head {
            Title {
                "Hello World"
            }
        }
        Body {
            H1 -Id "Title" {
                "My First Page"
            }
            Div -class 'hello' {
                "My First paragraph"
                "<span> and & and </span>"
                Div {
                    "Hello Again"
                }
            }
            for ($i = 0; $i -lt 4; $i++) {
                Span {"This is span number $i"}
            }
            Script {
                "alert('Hello world')"
            }
        }
    }
} -Verbose










# Example 2
New-HtmlString {
    "Hello world"
    "Goodbye" | ConvertTo-Xml -As String
} -Verbose










# Example 3
New-HtmlString {
    Span {"Hello world"}
    Span {"Goodbye"}
} -Verbose










# Example 4
$MyHeader = {
    H1 -Id "Title" {
        "My First Page"
    }
}
$MyDiv = {
    Div -class 'hello' {
        "My First paragraph"
        "<span> and & and </span>"
        Div {
            "Hello Again"
        }
    }
}
$MySpans = {
    for ($i = 0; $i -lt 4; $i++) {
        Span {"This is span number $i"}
    }
}
$MyScript = {
    Script {
        "alert('Hello world')"
    }
}
New-HtmlString {
    Html {
        Head {
            Title {
                "Hello World"
            }
        }
        Body {
            & $MyHeader
            & $MyDiv
            & $MySpans
            & $MyScript
            Br
            Script -Source "https://code.jquery.com/jquery-2.2.4.min.js"
        }
    }
} -Verbose










# Example 5
New-HtmlString {
    Html {
        Head {
            Title {"Markdown Example"}
        }
        Body {
            Markdown {
                cat ..\README.md -Raw
            }
        }
    }
} -Verbose










# Example 6
New-HtmlString {
    Div {
        Tag "thing" -CustomTag {
            "Hey"
        }
    }
} -Verbose