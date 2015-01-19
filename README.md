Set Cookie Analysis in Browsers
=======================================
License
-------
Released under AGPL (see LICENSE for more information).

Description
-----------
For more information see the following blog post: https://www.nccgroup.com/en/blog/2015/01/analysis-of-setting-cookies

Usage
-----
The "victim_site" directory should be copied on a server that supports ASPX (unless cookiemanager.aspx has been rewritten in PHP). 
This URL should be set inside the "testcase_runner.html" file in the "target_url" variable.

Other files can be deployed on a server which supports PHP or ASPX. If the server uses PHP, the following line needs to be used in the "modifyTestcaseContent" function:
	result = result.replace(/%%REDIRECTPAGE%%/g,'redirect.php');
	
The domain that contains the "victim_site" directory should be different than the domain which contains other files otherwise this cookie test can be pointless.

As an example, this can be set-up on a local Windows server with IIS. 
When victim.com and attacker.com are two local DNS names:

 - The "testcase_runner.html" file has the following line:
    var target_url = "http://victim.com/cookies-test/victim_site/";
 - And the main file is accessible via the following URL:
    http://attacker.com/cookie-test/testcase_runner.html

Example
-------
http://0me.me/demo/cookie-test/testcase_runner.html

This page sends its requests to the sdl.me server (an IIS server).

Project Page
------------
https://github.com/nccgroup/SetCookieAnalysisInBrowsers

Author
------
Soroush Dalili (@irsdl) from NCC Group

