<?php

namespace Controllers;

use Models\Cita;
use Models\CitaServicio;
use Models\Servicio;

class APIController
{
    public static function index()
    {
        $servicios = Servicio::all();
        echo json_encode($servicios);
    }

    public static function guardar()
    {
        $resultado = null;
        //Almacena la cita y devuelve el id
        $cita = new Cita($_POST);
        $resultado = $cita->guardar();

        $id = $resultado['id'];

        //Almacena los servicios con el id de una cita
        $idServicios = explode(",", $_POST['servicios']); //convierte a array

        foreach ($idServicios as $idServicio) {
            $args = [
                'citaId' => $id,
                'servicioId' => $idServicio
            ];

            $citaServicio = new CitaServicio($args);
            $citaServicio->guardar();
        }

        //Retornamos una respuesta
        echo json_encode(['resultado' => $resultado]);
    }
}
