<?php

$script = file_get_contents('http://localhost/mobility/documentos/bdTurismo.sql'); 
$dbservidor= "d8f50929-6563-4cab-b789-a3b301439625.mysql.sequelizer.com";
$dbusuario = "ijfgzyktrhpgjwya";
$dbpass = "UifYjeKHxTtSJ3WibKpQNNnAun4zeaqrMWdnwMeqSLZmLQmVBBmULpug5MC5jkDw";
$dbnombre = "ijfgzyktrhpgjwya";
$conexion = mysql_connect($dbservidor, $dbusuario ,$dbpass);
mysql_select_db($dbnombre, $conexion);
$query = mysql_query ('source ' . $script, $conexion);
if (!$query)
   echo 'Algo esta mal en el Query!!!';
die();
?>
