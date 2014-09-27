<?php

/**
 * Description of Facade
 *
 * @author andresilvagomez
 */
try {
    $class = $_GET["class"];
    $method = $_GET["method"];
    if (load($class, $method)) {
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
function load($class, $method) {
    $load = "../Model/$class.php";
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
