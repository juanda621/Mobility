<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//error_reporting(0);

/**
 * Description of city
 *
 * @author @andresilvagomez
 */
class connection {

    /**
     * Instancia la coneccion a la base de datos
     */
    public function conn() {
        $dbhost = 'd8f50929-6563-4cab-b789-a3b301439625.mysql.sequelizer.com';
        $dbuser = 'ijfgzyktrhpgjwya';
        $dbpass = 'UifYjeKHxTtSJ3WibKpQNNnAun4zeaqrMWdnwMeqSLZmLQmVBBmULpug5MC5jkDw';
        $dbname = 'dbd8f5092965634cabb789a3b301439625';

        $con = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
        if (mysqli_connect_errno($con)) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }
        return $con;
    }

    /**
     * Funcion que ejecuta una consulta SQL
     * @param String $query consulta
     * @return El resultado de la sonsulta echa
     */
    public function query($query) {
        try {
            
            $result = mysqli_query($this->conn(),$query);
            //$this->close();
            return $result;
        } catch (Exception $exc) {
            return "Ocurrio algo inesperado";
        }
    }

    /**
     * Funcion que compara si el resultado de una consulta es mayor a un limite
     * @param type $result resultado de la consulta depues de realizarla en la BD
     * @param type $limit limite sobre el cual se compara el numero de filas que devuelve la consulta
     * @return boolean retorna true si es menor o igual, false si es mayor
     */
    public function delimit($result, $limit) {
        try {
            if ($this->count_row($result) >= $limit) {
                return true;
            }
            return false;
        } catch (Exception $exc) {
            return "Ocurrio algo inesperado";
        }
    }

    /**
     * Cuenta la cantidad de filas que posee el resultado de la consulta
     * @param type $result resultado de la consulta depues de realizarla en la BD
     * @return integer numero de filas que posee la consulta
     */
    public function count_row($result) {
        try {
            if ($result != null) {
                return mysql_num_rows($result);
            }
            return 0;
        } catch (Exception $exc) {
            return "Ocurrio algo inesperado";
        }
    }

    /**
     * Funcion que cierra a conexion a la BD
     */
    public function close() {
        try {
            mysql_close();
        } catch (Exception $exc) {
            echo $exc->getTraceAsString();
        }
    }

    /**
     * Esta funcion se encarga de crear un array dentro de un json con los valores devueltos por una consulta
     * @param type $result resultado de la consulta depues de realizarla en la BD
     * @param Array $data_name Contiene un array con los nombres con los cuales quedaran los campos en el JSON
     * @return JSON retorna una estructura asi {result : [{,},{,}]}
     */
    public function fetch_array_json($result, $data_name) {
        $json = array();
        while ($row = mysql_fetch_array($result)) {
            for ($index = 0; $index < count($data_name); $index++) {
                $final[$data_name[$index]] = $row[$index];
            }
            array_push($json, $final);
            $final = null;
        }
        $final["result"] = $json;
        return json_encode($final);
    }

    /**
     * Esta funcion se encarga de crear una tabla con los valores devueltos por una consulta
     * @param type $result resultado de la consulta depues de realizarla en la BD
     * @param Array $titles Nombre de los Campos de encabezado de la tabla
     * @param String $class nombre de las clases visuales aplicadas a la tabla
     * @return string
     */
    public function fetch_array_table($result, $titles, $class) {
        $final = "<table class='$class'> <thead> <tr>";
        for ($index = 0; $index < count($titles); $index++) {
            $final.="<td>" . $titles[$index] . "</td>";
        }
        $final.="</tr></thead><tr>";
        while ($row = mysql_fetch_row($result)) {
            for ($index = 0; $index < count($row); $index++) {
                $final.="<td>" . $row[$index] . "</td>";
            }
            $final.="</tr>";
        }
        $final . "</table>";
        return $final;
    }

    public function encrypt($string, $key) {
        $result = '';
        for ($i = 0; $i < strlen($string); $i++) {
            $char = substr($string, $i, 1);
            $keychar = substr($key, ($i % strlen($key)) - 1, 1);
            $char = chr(ord($char) + ord($keychar));
            $result.=$char;
        }
        return base64_encode($result);
    }

    public function decrypt($string, $key) {
        $result = '';
        $string = base64_decode($string);
        for ($i = 0; $i < strlen($string); $i++) {
            $char = substr($string, $i, 1);
            $keychar = substr($key, ($i % strlen($key)) - 1, 1);
            $char = chr(ord($char) - ord($keychar));
            $result.=$char;
        }
        return $result;
    }

    /**
     * Este metodo genera una cadena aleatoria en base a la cadena de entrada y el numero de caracteres a retornar
     * @param type String Cadena sobre la cual se sacan los datos
     * @param type Number Numero de caracteres que debe contener la cadena a retornar
     * @return type String Cadena aleatoria generada
     */
    public function random_code($string, $number_caracters, $colum = null, $table = null) {
        $return = $this->code($string, $number_caracters);
        if ($colum == null) {
            return $return;
        }
        while ($this->count_row($this->query("SELECT $colum FROM $table WHERE $colum = '$return'")) > 0) {
            $return = $this->code($string, $number_caracters);
        }
        return $return;
    }

    /**
     *
     * @param type $param
     * @return type
     */
    private function code($string, $number_caracters) {
        $return = "";
        for ($index = 0; $index < $number_caracters; $index++) {
            $return .= $string[rand(0, strlen($string) - 1)];
        }
        return $return;
    }

    /**
     * El Operador cierra el sistema
     * @param type $param
     * @return type
     */
    public function close_session($param) {
        $username = $param["username"];
        $id_company = $param["id_company"];
        $query = " UPDATE  users_companies
                   SET `connection`=0
                   WHERE person_cc=$username
                   AND company_id=$id_company";
        $this->query($query);
        $query = " INSERT into session_users_companies
                        (person_cc, date,session)
                        values ( $username, NOW(), 0)";
        $this->query($query);

        $json["data"] = 1;
        return json_encode($json);
    }

    /**
     * El Operador se conecta al sistema
     * @param type $param
     * @return type
     */
    public function connect($param) {
        $username = $param["username"];
        $query = " INSERT into session_users_companies
                        (person_cc, date,session)
                        values ( $username, NOW(), 1)";
        $this->query($query);
        $json["data"] = 1;
        return json_encode($json);
    }

    /**
     * verifica que el usuario este en la base de datos
     * devuelve un array [tipo de usuario,compa単ia a la que pertenece]
     * @param type String
     * @param type String
     * @return type array
     */
    public function login($user, $password, $ip) {
        $query = "  SELECT  p.first_name, p.first_last_name, c.name, c.id
                    FROM users_companies uc, companies c, person p
                    WHERE p.cc = $user
                    AND uc.person_cc = p.cc
                    AND uc.password = '$password'
                    AND uc.enabled = 1
                    AND c.id=uc.company_id
                    AND c.enabled=1";
        $result = $this->query($query);
        if ($result) {
            $query = "UPDATE users_companies SET last_connection= NOW(), connection=1 WHERE person_cc=$user";
            if ($this->query($query)) {
                $row = mysql_fetch_row($result);
                $query = "INSERT historial_conecciones (user, ip) VALUES ('$user','$ip')";
                $this->query($query);
                return $row;
            }
        }
    }

    public function convert_array_json($result) {
        $json = array();
        $stack = array();
        while ($row = mysql_fetch_row($result)) {
            for ($index = 0; $index < count($row); $index++) {
                array_push($stack, $row[$index]);
            }
            array_push($json, $stack);
            $stack = array();
        }
        return json_encode($json);
    }

}

?>