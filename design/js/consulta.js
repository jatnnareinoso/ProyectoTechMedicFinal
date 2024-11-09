const express = require('express');
const client = require('./db'); 
const router = express.Router();

router.get('/informacion-cita/:id_cita', async (req, res) => {
    const { id_cita } = req.params;

    try {
        const citaQuery = `
            SELECT 
                p.id_paciente,
                CONCAT(p.nombre, ' ', p.apellido) AS nombre_paciente,
                p.cedula,
                d.id_doctor,
                ARRAY_AGG(json_build_object('id_especialidad', e.id_especialidad, 'nombre_especialidad', e.especialidad)) AS especialidades
            FROM 
                cita c
                JOIN paciente p ON c.id_paciente = p.id_paciente
                JOIN doctor d ON c.id_doctor = d.id_doctor
                JOIN doctor_especialidad de ON d.id_doctor = de.id_doctor
                JOIN especialidad e ON de.id_especialidad = e.id_especialidad
            WHERE 
                c.id_cita = $1
            GROUP BY 
                p.id_paciente, p.nombre, p.apellido, p.cedula, d.id_doctor
        `;

        const citaResult = await client.query(citaQuery, [id_cita]);

        if (citaResult.rows.length > 0) {
            res.status(200).json(citaResult.rows[0]);
        } else {
            res.status(404).json({ message: 'Información no encontrada para esta cita' });
        }
    } catch (error) {
        console.error('Error al obtener la información de la cita', error);
        res.status(500).json({ message: 'Error al obtener la información de la cita' });
    }
});

router.post('/registerConsulta', async (req, res) => {
    const { motivo, descripcion, fecha_hora, estado, id_cita, notas_internas, notas_externas, pruebas, id_especialidad } = req.body;

    try {

        const queryCita = `
            SELECT id_paciente from cita where id_cita=${id_cita}
        `;

        const resultCita = await client.query(queryCita);

        if (resultCita.rows.length > 0) {
            
            const id_paciente = resultCita.rows[0].id_paciente
            
            const consultaQuery = `
                INSERT INTO consulta (motivo, descripcion, fecha_hora, estado, id_cita, notas_internas, notas_externas, pruebas, id_especialidad, id_paciente)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
                RETURNING *;
            `;
            
            const values = [
                motivo,
                descripcion,
                fecha_hora,
                estado,
                id_cita,
                notas_internas,
                notas_externas,
                pruebas || null,
                id_especialidad,
                id_paciente
            ];
            
            const consultaResult = await client.query(consultaQuery, values);
            res.status(201).json(consultaResult.rows[0]); 
            
        }else{
            res.status(400).json({ message: 'La cita utilizada no existe.' })
        }
    } catch (error) {
        console.error('Error al agregar la consulta', error);
        res.status(500).json({ message: 'Error al agregar la consulta' });
    }
});

router.get('/consultasDoctor', async (req, res) => {
    const { id_doctor } = req.query;

    if (!id_doctor) {
        return res.status(400).json({ error: 'El id_doctor es obligatorio' });
    }

    try {
        const result = await client.query(
            `SELECT 
                c.id_consulta,
                c.fecha_hora AS fecha_consulta,
                e.id_especialidad,
                e.especialidad AS especialidad,
                CONCAT(p.nombre, ' ', p.apellido) AS nombre_paciente,
                CONCAT(u.nombre, ' ', u.apellido) AS doctor,
                c.motivo,
                c.descripcion,
                c.estado,
                c.notas_internas,
                c.notas_externas,
                c.pruebas
            FROM 
                consulta c
            JOIN 
                especialidad e ON c.id_especialidad = e.id_especialidad
            JOIN 
                cita ct ON c.id_cita = ct.id_cita
            JOIN 
                doctor d ON ct.id_doctor = d.id_doctor
            JOIN 
                usuario u ON d.id_usuario = u.id_usuario
            JOIN 
                paciente p ON c.id_paciente = p.id_paciente
            WHERE 
                d.id_doctor = $1
            ORDER BY 
                c.fecha_hora DESC;`,
            [id_doctor]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'No se encontraron consultas para este doctor.' });
        }

        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener consultas:', error);
        res.status(500).json({ error: 'Error al obtener consultas' });
    }
});

router.get('/consultasAsistente', async (req, res) => {
    const { id_usuario } = req.query;

    if (!id_usuario) {
        return res.status(400).json({ error: 'El id_usuario es obligatorio' });
    }

    try {
        const result = await client.query(
            `SELECT 
                ct.id_usuario,
                c.id_consulta,
                c.fecha_hora AS fecha_consulta,
                e.id_especialidad,
                e.especialidad AS especialidad,
                CONCAT(p.nombre, ' ', p.apellido) AS nombre_paciente,
                CONCAT(u.nombre, ' ', u.apellido) AS doctor,
                c.motivo,
                c.descripcion,
                c.estado,
                c.notas_internas,
                c.notas_externas,
                c.pruebas
            FROM 
                consulta c
            JOIN 
                especialidad e ON c.id_especialidad = e.id_especialidad
            JOIN 
                cita ct ON c.id_cita = ct.id_cita
            JOIN 
                doctor d ON ct.id_doctor = d.id_doctor
            JOIN 
                usuario u ON d.id_usuario = u.id_usuario
            JOIN 
                paciente p ON ct.id_paciente = p.id_paciente
            WHERE 
                ct.id_usuario = $1
            ORDER BY 
                c.fecha_hora DESC;
            `,
            [id_usuario]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'No se encontraron consultas para este usuario.' });
        }

        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener consultas:', error);
        res.status(500).json({ error: 'Error al obtener consultas' });
    }
});

router.get('/consultaId/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const result = await client.query(
            `SELECT 
                c.id_consulta,
                c.fecha_hora AS fecha_consulta,
                e.id_especialidad,
                e.especialidad AS especialidad,
                CONCAT(p.nombre, ' ', p.apellido) AS nombre_paciente,
                CONCAT(u.nombre, ' ', u.apellido) AS doctor,
                c.motivo,
                c.descripcion,
                c.estado,
                c.notas_internas,
                c.notas_externas,
                c.pruebas,
                ct.id_paciente

            FROM 
                consulta c
            JOIN 
                especialidad e ON c.id_especialidad = e.id_especialidad
            JOIN 
                cita ct ON c.id_cita = ct.id_cita
            JOIN 
                doctor d ON ct.id_doctor = d.id_doctor
            JOIN 
                usuario u ON d.id_usuario = u.id_usuario
            JOIN 
                paciente p ON ct.id_paciente = p.id_paciente
            WHERE 
                c.id_consulta = $1;`,
            [id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'Consulta no encontrada.' });
        }

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al obtener datos de la consulta:', error);
        res.status(500).json({ error: 'Error al obtener datos de la consulta' });
    }
});

router.put('/actualizarConsulta', async (req, res) => {
    const {
        id_consulta,
        id_especialidad,
        motivo,
        descripcion,
        fecha_hora,
        notas_internas,
        notas_externas,
        pruebas,
        estado
    } = req.body;

    if (!id_consulta) {
        return res.status(400).json({ error: 'El ID de la consulta es obligatorio.' });
    }

    try {
        const result = await client.query(
            `UPDATE consulta
             SET id_especialidad = $1,
                 motivo = $2,
                 descripcion = $3,
                 fecha_hora = $4,
                 notas_internas = $5,
                 notas_externas = $6,
                 pruebas = $7,
                 estado = $8
             WHERE id_consulta = $9
             RETURNING *;`,
            [
                id_especialidad,
                motivo,
                descripcion,
                fecha_hora,
                notas_internas,
                notas_externas,
                pruebas,
                estado,
                id_consulta
            ]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ message: 'No se encontró la consulta para actualizar.' });
        }

        res.json({ success: true, consulta: result.rows[0] });
    } catch (error) {
        console.error('Error al actualizar la consulta:', error);
        res.status(500).json({ error: 'Error al actualizar la consulta' });
    }
});

module.exports = router;