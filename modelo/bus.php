<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once '../Model/connection.php';
include_once '../Model/mail.php';
include_once '../Model/city.php';
include_once '../Model/internationalization.php';
include_once '../Model/push_notification.php';
include_once '../Model/usuario.php';

/**
 * Description of user
 *
 * @author @andresilvagomez
 */
class bus {

    //put your code here
    private $connection;

    public function __construct() {
        $this->connection = new connection();
    }

    public function obtener_posicion_buses($param) {
        $files = array(
    array(
        'name' => 'uimg',
        'type' => 'image/jpeg',
        'file' => './profile.jpg',
    )
);

     $post = http_post_fields("http://www.example.com/", $fields, $files);
    return $post;
    }
   

}

?>
