<?php

include_once '../Model/connection_citytaxi.php';

header('Access-Control-Allow-Origin: *');


    $ruta1["inicio"] = array("latitud" => 5.066863, "longitud" =>-75.524442);
    $ruta1["intermedio"] = array("latitud" =>5.064469, "longitud" =>-75.498993);
    $ruta1["fin"] = array("latitud" => 5.054247, "longitud" => -75.463910);
    
    $ruta2["inicio"] = array("latitud" =>5.074510, "longitud" => -75.508775);
    $ruta2["intermedio"] = array("latitud" => 5.064469  , "longitud" => -75.498993);
    $ruta2["fin"] = array("latitud" => 5.064469, "longitud" => -75.498993);
    
    $ruta3["inicio"] = array("latitud" =>5.064469, "longitud" => -75.498993);
    $ruta3["intermedio"] = array("latitud" => 5.064469 , "longitud" => -75.498993);
    $ruta3["fin"] = array("latitud" => 5.064469, "longitud" => -75.498993);
    
    $data=array($ruta1,$ruta2,$ruta3);
    
 
    $json["estado"] = true;
    $json["taxis"] = $data;
    echo json_encode($json);

