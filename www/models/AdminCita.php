<?php

namespace Models;

use Models\ActiveRecord;

class AdminCita extends ActiveRecord
{
    protected static $tabla = 'citasServicios';
    protected static $columnasDB = ['id', 'hora', 'cliente', 'email', 'telefono', 'servicio', 'precio'];

    public $id;
    public $hora;
    public $cliente;
    public $email;
    public $telefono;
    public $servicio;
    public $precio;

    public function __construct($args = [])
    {
        $this->id = $args['id'] ?? null;
        $this->hora = $args['hora'] ?? '';
        $this->cliente = $args['cliente'] ?? '';
        $this->email = $args['email'] ?? '';
        $this->telefono = $args['telefono'] ?? '';
        $this->servicio = $args['servicio'] ?? '';
        $this->precio = $args['precio'] ?? '';
    }

    //CONSULTA SQL PARA ESTE MODELO
    /*
        SELECT citas.id, citas.hora, CONCAT(usuarios.nombre, ' ', usuarios.apellido) AS cliente, usuarios.email, usuarios.telefono, servicios.nombre AS servicio, servicios.precio FROM citas LEFT OUTER JOIN usuarios ON citas.usuarioId = usuarios.id LEFT OUTER JOIN citasServicios ON citasServicios.citaId = citas.id LEFT OUTER JOIN servicios ON citasServicios.servicioId = servicios.id;
    
    */
}
