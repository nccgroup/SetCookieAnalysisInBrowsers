<%@ Page Language="VB" validateRequest="false" %> 
<script language="VB" runat="Server"> 
Dim cookiePrefix as String = "CheckCookie_LabTest_" ' Must have a unique value for security reasons
Sub Page_Load()
	Dim action as String = Request.QueryString("action")

	Select Case LCase(action)
		case "setcookiebyreferrer"
			call setCookieByReferrer()
		case "setcookie"
			call setCookie()
		case "showcookie"
			call showCookie()
		case "showallcookies"
			' should be disabled for security reasons
			call showAllCookies()
		Case "clearcookies"
			call clearCookies()
		Case Else
			Response.write("Error!")
			Response.end()
	End Select
End sub

Function setCookieByReferrer()
	Dim inputCookieName,inputCookieValue as String
	Try
		Response.CacheControl = "no-cache" 
		Response.AddHeader ("Pragma", "no-cache")
		Response.AddHeader ("X-Frame-Options", "DENY")
		Response.AddHeader ("X-Content-Security-Policy", "allow 'self'; frame-ancestors 'none'")
		Response.AddHeader ("X-Content-Type-Options", "nosniff")
		Response.AddHeader ("X-XSS-Protection", "1; mode=block")
		'Response.AddHeader ("P3P", "CP=""FooBar""")

		Dim referrer as String = Request.QueryString("referrer")
		If referrer = "" Then
			inputCookieName = System.IO.Path.GetFileName(Request.UrlReferrer.AbsolutePath)
		Else
			inputCookieName = referrer
		End If
		inputCookieName = replace(inputCookieName,";","_")
		inputCookieName = replace(inputCookieName,"\","_")
		inputCookieValue = Request.QueryString("cookievalue")
		inputCookieValue = replace(inputCookieValue,";","_")
		inputCookieValue = replace(inputCookieValue,"\","_")
		Response.Cookies(cookiePrefix & inputCookieName).Value = inputCookieValue		
		Response.write("Done. This cookie was created: " & Server.HtmlEncode(cookiePrefix & inputCookieName) & " = " & Server.HtmlEncode(inputCookieValue))
		'Response.Flush
	Catch
	
	End Try
End Function

Function setCookie()
	Dim inputCookieName,inputCookieValue as String
	inputCookieName = Request.QueryString("cookiename")
	inputCookieName = replace(inputCookieName,";","_")
	inputCookieName = replace(inputCookieName,"\","_")
	inputCookieValue = Request.QueryString("cookievalue")
	inputCookieValue = replace(inputCookieValue,";","_")
	inputCookieValue = replace(inputCookieValue,"\","_")
	Response.Cookies(cookiePrefix & inputCookieName).Value = inputCookieValue
End Function

Function showCookie()
	Try
		Dim origin as String = request.Headers.GetValues("Origin")(0)
		Response.AddHeader ("Access-Control-Allow-Origin", origin)
		Response.AddHeader ("Access-Control-Allow-Credentials", "true")
		Response.AddHeader ("Access-Control-Allow-Methods", "GET, POST")
		
		Dim inputCookieName,inputCookieValue as String
		inputCookieName = Request.QueryString("cookiename")
		inputCookieName = replace(inputCookieName,";","_")
		inputCookieName = replace(inputCookieName,"\","_")
		inputCookieValue = Request.Cookies(cookiePrefix & inputCookieName).Value
		Response.write("This cookie is available: " & Server.HtmlEncode(cookiePrefix & inputCookieName) & " = " & Server.HtmlEncode(inputCookieValue))
	Catch
	
	End Try		
End Function

Function showAllCookies()
	Dim i As Integer
	Dim output As String = ""
	Dim aCookie As HttpCookie
	For i = 0 to Request.Cookies.Count - 1
		aCookie = Request.Cookies(i)
		output &= "Cookie name = " & Server.HtmlEncode(aCookie.Name) & "<br>"
		output &= "Cookie value = " & Server.HtmlEncode(aCookie.Value) & "<br><br>"
	Next 

	Response.write(output)
End Function

Function clearCookies()
	Dim i As Integer
	Dim aCookie As HttpCookie
	Dim limit As Integer = Request.Cookies.Count - 1
	For i = 0 To limit
	   aCookie = Request.Cookies(i)
	   aCookie.Expires = DateTime.Now.AddDays(-1)
	   Response.Cookies.Add(aCookie)
	Next
	Response.write("Cookies cleared!")
End Function
</script>