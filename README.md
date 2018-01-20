# HTML Template

A powershell html templating system

## Example

```
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
            Div 
            Script {
                "alert('Hello world')"
            }
        }
    }
}
```