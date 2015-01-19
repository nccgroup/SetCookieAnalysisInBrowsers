<%
Dim dest,rdircode
dest = request("rdir")
rdircode = request("rdircode")

'Response.AddHeader ("P3P", "CP=""FooBar""") ' needed for IE...
Response.AddHeader ("X-XSS-Protection", "0")
If Not request.Headers.GetValues("Origin") Is Nothing Then
	Dim origin as String = request.Headers.GetValues("Origin")(0)
	Response.AddHeader ("Access-Control-Allow-Origin", origin)
End If
Response.AddHeader ("Access-Control-Allow-Credentials", "true")
Response.AddHeader ("Access-Control-Allow-Methods", "GET, POST")

Select Case rdircode
	Case "307"
		Response.Status = "307 Temporary Redirect"
		Response.AddHeader ("location", dest)
	Case "308"
		Response.Status = "308 Permanent Redirect"
		Response.AddHeader ("location", dest)
	Case Else
		Response.RedirectPermanent(dest)
End Select
%>