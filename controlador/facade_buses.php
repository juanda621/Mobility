<?php

header('Access-Control-Allow-Origin: *');
/**
 * Esta clase Recibe el nombre de la function que desea invocar, de la clase user
 * y en via estos paramatros por el methodo POST
 * @author andresilvagomez
 */
try {
    $class = "bus";
    $method = $_GET["method"];
    $private_code = $_POST["private_code"];
    if (load($class, $method, $private_code)) {
        $obj = new $class();
        echo $obj->$method($_POST);
    }
} catch (Exception $e) {
    echo json_encode(array("mensaje" => $e->getMessage()));
}

/**
 * Incluye en el documento la instancia de la clase.
 * @param type $class
 * @return boolean si el archivo existe
 * @throws Exception
 */
function load($class, $method, $private_code) {
    $load = "../modelo/$class.php";
    if (file_exists($load)) {
        include_once ($load);
        if (!method_exists($class, $method)) {
            throw new Exception("No existe el metodo $method");
            return false;
        }
        return true;
    } else {
        throw new Exception("No existe la clase $class");
        return false;
    }
}

?>
