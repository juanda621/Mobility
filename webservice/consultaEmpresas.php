<?php

include_once '../modelo/connection.php';
header('Access-Control-Allow-Origin: *');

$connection = new connection();

$connection->conn();

$query = "select * from empresas";

$result = $connection->query($query);

$records = array();

while ($row = mysql_fetch_assoc($result)) {

    $records[] = $row;
}

echo json_encode($records);
?>
