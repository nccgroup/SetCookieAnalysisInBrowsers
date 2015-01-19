<?php
//ob_start(); 
//ob_get_clean(); 
//ob_get_clean(); 
$rdir = $_GET['rdir'];
$rdircode = $_GET['rdircode'];
// header('P3P: CP="FooBar"'); // Needed for IE
header('X-XSS-Protection: 0');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET, POST');
if (isset($_SERVER['HTTP_ORIGIN'])) {
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    }

switch ($rdircode) {
    case 307:
	case 308:
        header('Location: ' . $rdir, true, $rdircode);
        break;
    default:
		$rdircode = 301;
        header('Location: ' . $rdir, true, $rdircode);
}
die();
?> 