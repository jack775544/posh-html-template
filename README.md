# HTML Template

A powershell html templating system

## Setup

In Powershell (v5 or v6 both work)
```
git clone https://github.com/jack775544/posh-html-template
Import-Module posh-html-template\html-template.psd1
```

## Example

```powershell
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
}
```