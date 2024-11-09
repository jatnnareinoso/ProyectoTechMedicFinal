const express = require('express');
const router = express.Router();
const client = require('./db'); 
const sgMail = require('@sendgrid/mail');

router.get('/recibidos', async (req, res) => {
    const { id_usuario } = req.query;

    if (!id_usuario) {
        return res.status(400).json({ error: 'El id_usuario es obligatorio' });
    }

    try {
        const result = await client.query(
            `SELECT 
                n.id_notificaciones,
                n.id_usuario AS id_remitente,
                n.correo,
                n.fecha_envio,
                n.contenido,
                n.estado,
                n.id_destinatario,
                n.tipo_destinatario,
                u.nombre AS nombre_remitente,
                u.apellido AS apellido_remitente
            FROM 
                notificaciones n
            LEFT JOIN 
                usuario u ON n.id_usuario = u.id_usuario
            WHERE 
                n.id_destinatario = $1
                AND n.tipo_destinatario = 'usuario'
            ORDER BY 
                n.fecha_envio DESC;`,
            [id_usuario]
        );

        console.log('Notificaciones recibidas:', result.rows); 

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'No se encontraron notificaciones para este usuario.' });
        }

        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener notificaciones recibidas:', error);
        res.status(500).json({ error: 'Error al obtener notificaciones recibidas' });
    }
});

router.get('/enviados', async (req, res) => {
    const { id_usuario } = req.query;

    if (!id_usuario) {
        return res.status(400).json({ error: 'El id_usuario es obligatorio' });
    }

    try {
        const result = await client.query(
            `SELECT 
                n.id_notificaciones,
                n.id_usuario AS id_remitente,
                n.id_destinatario,
                n.tipo_destinatario,
                n.correo,
                n.fecha_envio,
                n.contenido,
                n.estado,
                CASE
                    WHEN n.tipo_destinatario = 'usuario' THEN u.nombre || ' ' || u.apellido
                    WHEN n.tipo_destinatario = 'paciente' THEN p.nombre || ' ' || p.apellido
                    ELSE 'Desconocido'
                END AS nombre_destinatario
            FROM 
                notificaciones n
            LEFT JOIN 
                usuario u ON n.tipo_destinatario = 'usuario' AND n.id_destinatario = u.id_usuario
            LEFT JOIN 
                paciente p ON n.tipo_destinatario = 'paciente' AND n.id_destinatario = p.id_paciente
            WHERE 
                n.id_usuario = $1
            ORDER BY 
                n.fecha_envio DESC;`,
            [id_usuario]
        );

        console.log('Notificaciones enviadas:', result.rows); 

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'No se encontraron notificaciones enviadas por este usuario.' });
        }

        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener notificaciones enviadas:', error);
        res.status(500).json({ error: 'Error al obtener notificaciones enviadas' });
    }
});


router.get('/usuarios', async (req, res) => {
    try {
        const result = await client.query('SELECT id_usuario, nombre, apellido, correo FROM usuario');
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener usuarios:', error);
        res.status(500).json({ message: 'Error al obtener usuarios' });
    }
});

router.get('/pacientes', async (req, res) => {
    try {
        const result = await client.query('SELECT id_paciente, nombre, apellido, correo FROM paciente');
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener pacientes:', error);
        res.status(500).json({ message: 'Error al obtener pacientes' });
    }
});

router.post('/registrarNotificacion', async (req, res) => {
    const { id_usuario, id_destinatario, tipo_destinatario, contenido } = req.body;

    let query;
    if (tipo_destinatario === 'usuario') {
        query = 'SELECT correo FROM usuario WHERE id_usuario = $1';
    } else if (tipo_destinatario === 'paciente') {
        query = 'SELECT correo FROM paciente WHERE id_paciente = $1';
    } else {
        return res.status(400).json({ message: 'Tipo de destinatario inválido' });
    }

    try {
        const result = await client.query(query, [id_destinatario]);
        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'Destinatario no encontrado' });
        }

        const correo = result.rows[0].correo;
        const fechaActual = new Date();

        await client.query(
            `INSERT INTO notificaciones (id_usuario, id_destinatario, tipo_destinatario, correo, contenido, estado, fecha_envio)
             VALUES ($1, $2, $3, $4, $5, $6, $7)`,
            [id_usuario, id_destinatario, tipo_destinatario, correo, contenido, true, fechaActual]
        );

        if (tipo_destinatario === 'paciente') {
            const msg = {
                to: correo,
                from: 'tecnologiamedicinaltechmedic@gmail.com',
                subject: 'Notificación importante',
                text: `${contenido}\nFecha: ${fechaActual.toLocaleString()}`,
                html: `<p>${contenido}</p><p><strong>Fecha:</strong> ${fechaActual.toLocaleString()}</p>`
            };

            try {
                await sgMail.send(msg);
                console.log('Correo enviado exitosamente');
            } catch (error) {
                console.error('Error al enviar correo:', error);
                return res.status(500).json({ message: 'Error al enviar correo al paciente' });
            }
        }

        res.json({ message: 'Notificación registrada exitosamente' });
    } catch (error) {
        console.error('Error al registrar notificación:', error);
        res.status(500).json({ message: 'Error al registrar notificación' });
    }
});


module.exports = router;
