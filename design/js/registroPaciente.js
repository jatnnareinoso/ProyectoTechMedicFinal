const express = require('express');
const router = express.Router();
const pool = require('./db'); 

const registrarPaciente = async (req, res) => {
    const {
        nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion,
        celular, userType, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar,
        peso, altura, alergia, detalleAlergia, enfermedad, detalleEnfermedad, sustancia, detalleSustancia
    } = req.body;

    const menor = userType === 'menor';

    try {
        const result = await pool.query(`
            INSERT INTO paciente (
                nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, celular, menor,
                nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar,
                peso, altura, alergia, enfermedad, sustancia
            ) VALUES (
                $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12,
                $13, $14, $15, $16, $17,
                $18, $19, $20, $21, $22
            ) RETURNING id_paciente
        `, [
            nombre, apellido, cedula || null, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, celular,
            menor, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar,
            peso, altura,
            alergia === 'si' ? detalleAlergia : null,
            enfermedad === 'si' ? detalleEnfermedad : null,
            sustancia === 'si' ? detalleSustancia : null
        ]);

        const { id_paciente } = result.rows[0];
        res.status(201).json({ success: true, message: 'Paciente registrado exitosamente', id_paciente });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, error: 'Error al registrar paciente' });
    }
};

const buscarPacientePorCedula = async (cedula) => {
    try {
        const result = await pool.query('SELECT nombre, apellido FROM paciente WHERE cedula = $1', [cedula]);

        if (result.rows.length > 0) {
            return { existe: true, nombre: result.rows[0].nombre, apellido: result.rows[0].apellido };
        } else {
            return { existe: false };
        }
    } catch (error) {
        console.error('Error al buscar paciente:', error);
        throw new Error('Error al buscar paciente.');
    }
};


module.exports = { registrarPaciente, buscarPacientePorCedula };
