<?php

class Categoria 
{
    function consultarCategorias ($id)
    {
        $query =  "SELECT e.nombre from estadoanimo e, empresas_estadoanimo  ee
                   WHERE  e.id_estadoanimo= ee.id_estadoanimo
                    AND ee.id_empresa= ";
    }
}
?>
