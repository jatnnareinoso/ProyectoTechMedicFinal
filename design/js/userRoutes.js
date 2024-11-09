const express = require('express');
const router = express.Router();
const crypto = require('crypto');
const sgMail = require('@sendgrid/mail');

module.exports = (client) => {
    router.get('/centros_medicos', async (req, res) => {
        try {
            const result = await client.query('SELECT id_centro_medico, centro_medico FROM centro_medico');
            res.json(result.rows);
        } catch (error) {
            console.error('Error en la consulta de centros médicos:', error);
            res.status(500).send('Error interno del servidor');
        }
    });

    router.get('/especialidades', async (req, res) => {
        try {
            const result = await client.query('SELECT id_especialidad, especialidad, descripcion, estado FROM especialidad');
            res.json(result.rows);
        } catch (error) {
            console.error('Error en la consulta de especialidades:', error);
            res.status(500).send('Error interno del servidor');
        }
    });

    router.put('/especialidades/:id', async (req, res) => {
        const { id } = req.params;
        const { especialidad, descripcion, estado } = req.body;
    
        try {
            const result = await client.query(
                'UPDATE especialidad SET especialidad = $1, descripcion = $2, estado = $3 WHERE id_especialidad = $4 RETURNING *',
                [especialidad, descripcion, estado, id]
            );
    
            if (result.rowCount === 0) {
                return res.status(404).send('Especialidad no encontrada');
            }
    
            res.json(result.rows[0]);
        } catch (error) {
            console.error('Error al actualizar la especialidad:', error);
            res.status(500).send('Error interno del servidor');
        }
    });

    router.post('/especialidades', async (req, res) => {
        const { especialidad, descripcion, estado } = req.body;
    
        try {
            const result = await client.query(
                'INSERT INTO especialidad (especialidad, descripcion, estado) VALUES ($1, $2, $3) RETURNING *',
                [especialidad, descripcion, estado]
            );
    
            const nuevaEspecialidad = result.rows[0];
    
            await client.query(
                'INSERT INTO accesos (id_especialidad, modulo, estado) VALUES ($1, $2, $3)',
                [nuevaEspecialidad.id_especialidad, nuevaEspecialidad.especialidad, true]
            );
    
            res.status(201).json(nuevaEspecialidad);
        } catch (error) {
            console.error('Error al agregar la especialidad:', error);
            res.status(500).send('Error interno del servidor');
        }
    });

    router.post('/register', async (req, res) => {
        const {
            userType, nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, exequatur,
            id_centro_medico, correo, id_especialidades, id_doctores 
        } = req.body;
    
        let id_tipo_usuario;
        if (userType === 'Administrador') {
            id_tipo_usuario = 1;
        } else if (userType === 'Doctor') {
            id_tipo_usuario = 2;
        } else if (userType === 'Asistente Administrativo') {
            id_tipo_usuario = 3;
        } else {
            return res.status(400).json({ message: 'Tipo de usuario no válido' });
        }
    
        const fechaNacimiento = new Date(fecha_nacimiento);
        const year = fechaNacimiento.getFullYear().toString().slice(-2); 
        const randomSuffix = crypto.randomBytes(2).toString('hex');
        const inicialNombre = nombre.toLowerCase().charAt(0); 
        const inicialApellido = apellido.toLowerCase().charAt(0); 
    
        const nombreUsuario = `${nombre.toLowerCase().slice(0, 3)}${apellido.toLowerCase().slice(0, 2)}${year}${inicialNombre}${inicialApellido}${randomSuffix}`;
        const password = crypto.randomBytes(8).toString('hex');
    
        try {
            const correoExistente = await client.query('SELECT 1 FROM usuario WHERE correo = $1', [correo]);
            if (correoExistente.rows.length > 0) {
                return res.status(409).json({ message: 'El correo ya está en uso' });
            }
    
            const cedulaExistente = await client.query('SELECT 1 FROM usuario WHERE cedula = $1', [cedula]);
            if (cedulaExistente.rows.length > 0) {
                return res.status(409).json({ message: 'Existe un usuario registrado con ese número de identificación' });
            }
    
            await client.query('BEGIN');
    
            const insertUsuarioQuery = `
                INSERT INTO usuario (nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, id_tipo_usuario, usuario, password)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id_usuario
            `;
    
            const { rows: usuarioResult } = await client.query(insertUsuarioQuery, [nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, id_tipo_usuario, nombreUsuario, password]);
            const id_usuario = usuarioResult[0].id_usuario;
    
            await client.query(`
                INSERT INTO usuario_centro_medico (id_usuario, id_centro_medico, estado)
                VALUES ($1, $2, true)
            `, [id_usuario, id_centro_medico]);
            console.log(`Usuario ${id_usuario} asociado con el centro médico ${id_centro_medico}`);
    
            if (id_tipo_usuario === 2) { 
                const insertDoctorQuery = `
                    INSERT INTO doctor (id_usuario, exequatur, estado)
                    VALUES ($1, $2, true) RETURNING id_doctor
                `;
    
                const { rows: doctorResult } = await client.query(insertDoctorQuery, [id_usuario, exequatur]);
                const id_doctor = doctorResult[0].id_doctor;
    
                if (Array.isArray(id_especialidades) && id_especialidades.length > 0) {
                    const values = id_especialidades.map((_, index) => `($1, $${index + 2})`).join(', ');
                    const insertDoctorEspecialidadQuery = `
                        INSERT INTO doctor_especialidad (id_doctor, id_especialidad)
                        VALUES ${values}
                    `;
                    await client.query(insertDoctorEspecialidadQuery, [id_doctor, ...id_especialidades]);
                    console.log(`Especialidades insertadas para el doctor ${id_doctor}`);
                }
    
                const insertDoctorCentroMedicoQuery = `
                    INSERT INTO doctor_centro_medico (id_doctor, id_centro_medico, estado)
                    VALUES ($1, $2, true)
                `;
                await client.query(insertDoctorCentroMedicoQuery, [id_doctor, id_centro_medico]);
                console.log(`Doctor ${id_doctor} asociado con el centro médico ${id_centro_medico}`);
            }
    
            if (id_tipo_usuario === 3) {
                if (!Array.isArray(id_doctores) || id_doctores.length === 0) {
                    return res.status(400).json({ message: 'Debe seleccionar al menos un doctor para este asistente administrativo' });
                }
    
                const values = id_doctores.map((_, index) => `($1, $${index + 2})`).join(', ');
                const insertUsuarioDoctorQuery = `
                    INSERT INTO asistente_doctor (id_usuario, id_doctor)
                    VALUES ${values}
                `;
                await client.query(insertUsuarioDoctorQuery, [id_usuario, ...id_doctores]);
                console.log(`Asistente administrativo ${id_usuario} asociado con los doctores ${id_doctores}`);
            }
    
            const msg = {
                to: correo,
                from: 'tecnologiamedicinaltechmedic@gmail.com', 
                subject: 'TechMedic - Credenciales',
                text: `Hola ${nombre} ${apellido}, tu registro fue exitoso.\n\nAquí tienes tus credenciales de acceso:\nUsuario: ${nombreUsuario}\nContraseña: ${password}\n\nTe recomendamos cambiar tu contraseña después de iniciar sesión.`
            };
    
            await sgMail.send(msg);
            await client.query('COMMIT');
            res.status(201).json({ message: 'Usuario registrado y correo enviado exitosamente' });
    
        } catch (error) {
            await client.query('ROLLBACK');
            console.error('Error al registrar el usuario o enviar el correo:', error);
            res.status(500).json({ message: 'Error interno del servidor' });
        }
    });
    

    router.post('/api/logout', (req, res) => {
        req.session.destroy((err) => {
            if (err) {
                return res.status(500).json({ error: 'Error al cerrar sesión' });
            }
            res.clearCookie('connect.sid'); 
            return res.status(200).json({ message: 'Sesión cerrada correctamente' });
        });
    });

    return router;
};
