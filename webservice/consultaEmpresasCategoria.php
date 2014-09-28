<?php

include_once '../modelo/connection.php';
header('Access-Control-Allow-Origin: *');

$connection = new connection();

$connection->conn();

$query = "select * from empresas";

$result = $connection->query($query);

$records = array();

while ($row = mysql_fetch_assoc($result)) {
    $querycategorias = "SELECT e.nombre as id
                        FROM estadoanimo e, empresas_estadoanimo  ee
                        WHERE  e.id_estadoanimo= ee.id_estadoanimo
                        AND ee.id_empresa= " . $row['id_empresa'];
    $result2 = $connection->query($querycategorias);
    if ($result2) {
        $records2 = array();
        while ($row2 = mysql_fetch_assoc($result2)) {

            $records2[] = $row2;
            $row['categorias'] = $records2;
        }
       
    }
    $records[] = $row;
}


echo json_encode($records);
?>
