const express = require('express');
const client = require('./db');
const router = express.Router();

const obtenerPerfilesUsuarios = async () => {
  try {
    const query = `
      SELECT u.id_usuario, 
             u.id_tipo_usuario, 
             u.nombre, 
             u.apellido, 
             u.cedula, 
             u.fecha_nacimiento, 
             u.sexo, 
             u.correo, 
             u.estado, 
             u.celular, 
             u.telefono,
             u.usuario,
             u.password,
             d.exequatur, 
             ARRAY_AGG(e.especialidad) AS especialidades  -- Agrupar todas las especialidades
      FROM usuario u
      LEFT JOIN doctor d ON u.id_usuario = d.id_usuario
      LEFT JOIN doctor_especialidad de ON d.id_doctor = de.id_doctor  -- Relación con la tabla doctor_especialidad
      LEFT JOIN especialidad e ON de.id_especialidad = e.id_especialidad  -- Relación con la tabla especialidad
      GROUP BY u.id_usuario, d.exequatur  -- Agrupar por id_usuario y exequatur (id_doctor ya se gestiona con el JOIN)
      ORDER BY u.id_usuario;
    `;
    const result = await client.query(query);
    return result.rows;
  } catch (err) {
    console.error('Error al obtener perfiles de usuarios:', err.message);
    return [];
  }
};

const obtenerUsuarioPorId = async (id_usuario) => {
    const query = 'SELECT * FROM usuario WHERE id_usuario = $1'; 
    try {
        const result = await client.query(query, [id_usuario]);
        return result.rows[0]; 
    } catch (error) {
        console.error('Error al obtener usuario:', error);
        throw new Error('Error al obtener usuario');
    }
};

const obtenerEspecialidades = async () => {
    const query = 'SELECT * FROM especialidad';
    try {
        const result = await client.query(query);
        return result.rows; 
    } catch (error) {
        console.error('Error al obtener especialidades:', error);
        throw new Error('Error al obtener especialidades');
    }
};

router.get('/api/doctor/:id_usuario', async (req, res) => {
    const id_usuario = req.params.id_usuario;

    try {
        const doctorInfo = await obtenerDoctorPorId(id_usuario);
        const especialidadesDoctor = await obtenerEspecialidadesDoctor(id_usuario); 
        const todasEspecialidades = await obtenerEspecialidades();

        console.log({
            doctor: doctorInfo,
            especialidadesDoctor,
            todasEspecialidades
        }); 

        res.json({
            doctor: doctorInfo,
            especialidadesDoctor,
            todasEspecialidades
        });
    } catch (error) {
        console.error('Error al obtener doctor:', error);
        res.status(500).json({ error: 'Error al obtener doctor' });
    }
});

const obtenerEspecialidadesDoctor = async (id_usuario) => {
    const query = `
        SELECT e.id_especialidad, e.especialidad
        FROM doctor_especialidad de
        JOIN especialidad e ON de.id_especialidad = e.id_especialidad
        WHERE de.id_doctor = (SELECT id_doctor FROM doctor WHERE id_usuario = $1)
    `;
    try {
        const result = await client.query(query, [id_usuario]);
        return result.rows; 
    } catch (error) {
        console.error('Error al obtener especialidades del doctor:', error);
        throw new Error('Error al obtener especialidades del doctor');
    }
};


const actualizarAdministrador = async (id_usuario, datosActualizados) => {
    const { nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, usuario, password, estado } = datosActualizados;
    const query = `
        UPDATE usuario
        SET nombre = $1, apellido = $2, fecha_nacimiento = $3, sexo = $4, celular = $5,
            telefono = $6, cedula = $7, correo = $8, usuario = $9, password = $10, estado = $11
        WHERE id_usuario = $12
    `;
    try {
        const result = await client.query(query, [nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, usuario, password, estado, id_usuario]);
        return result.rowCount > 0 ? { mensaje: 'Administrador actualizado' } : { error: 'Administrador no encontrado' };
    } catch (error) {
        console.error('Error al actualizar administrador:', error);
        throw new Error('Error al actualizar administrador');
    }
};

const actualizarDoctor = async (id_usuario, datosActualizados) => {
    const { nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, usuario, password, exequatur, id_especialidad, estado } = datosActualizados;

    const queryUsuario = `
        UPDATE usuario
        SET nombre = $1, apellido = $2, fecha_nacimiento = $3, sexo = $4, celular = $5,
            telefono = $6, cedula = $7, correo = $8, usuario = $9, password = $10, estado = $11
        WHERE id_usuario = $12
    `;

    const queryDoctor = `
        UPDATE doctor
        SET exequatur = $1
        WHERE id_usuario = $2
    `;

    const queryObtenerEspecialidadesActuales = `
        SELECT id_especialidad FROM doctor_especialidad WHERE id_doctor = (SELECT id_doctor FROM doctor WHERE id_usuario = $1)
    `;

    const queryEliminarEspecialidades = `
        DELETE FROM doctor_especialidad WHERE id_doctor = (SELECT id_doctor FROM doctor WHERE id_usuario = $1)
    `;

    const queryAgregarEspecialidades = `
        INSERT INTO doctor_especialidad (id_doctor, id_especialidad) 
        VALUES ((SELECT id_doctor FROM doctor WHERE id_usuario = $1), $2)
    `;

    try {
        await client.query('BEGIN');

        await client.query(queryUsuario, [nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, usuario, password, estado, id_usuario]);

        await client.query(queryDoctor, [exequatur, id_usuario]);

        const { rows: especialidadesActuales } = await client.query(queryObtenerEspecialidadesActuales, [id_usuario]);
        const idsEspecialidadesActuales = especialidadesActuales.map(e => e.id_especialidad);

        if (JSON.stringify(idsEspecialidadesActuales) !== JSON.stringify(id_especialidad)) {

            await client.query(queryEliminarEspecialidades, [id_usuario]);

            for (const especialidad of id_especialidad) {
                await client.query(queryAgregarEspecialidades, [id_usuario, especialidad]);
            }
        }

        await client.query('COMMIT');

        return { mensaje: 'Doctor actualizado con especialidades' };
    } catch (error) {
        await client.query('ROLLBACK');
        console.error('Error al actualizar doctor:', error);
        throw new Error('Error al actualizar doctor');
    }
};

const actualizarAsistente = async (id_usuario, datosActualizados) => {
    const { nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, usuario, password, id_doctor, estado } = datosActualizados;

    const queryUsuario = `
        UPDATE usuario
        SET nombre = $1, apellido = $2, fecha_nacimiento = $3, sexo = $4, celular = $5,
            telefono = $6, cedula = $7, correo = $8, usuario = $9, password = $10, estado = $11
        WHERE id_usuario = $12
    `;

    const queryEliminarDoctores = `
        DELETE FROM asistente_doctor WHERE id_usuario = $1
    `;

    const queryAgregarDoctores = `
        INSERT INTO asistente_doctor (id_usuario, id_doctor)
        VALUES ($1, $2)
    `;

    try {
        await client.query('BEGIN'); 
    
        await client.query(queryUsuario, [nombre, apellido, fecha_nacimiento, sexo, celular, telefono, cedula, correo, usuario, password, estado, id_usuario]);
    
        const { rows: doctoresActuales } = await client.query('SELECT id_doctor FROM asistente_doctor WHERE id_usuario = $1', [id_usuario]);
        const idsDoctoresActuales = doctoresActuales.map(d => d.id_doctor);
    
        if (JSON.stringify(idsDoctoresActuales) !== JSON.stringify(id_doctor)) {
            console.log("Eliminando doctores actuales...");
            await client.query(queryEliminarDoctores, [id_usuario]);

            for (const idDoctor of id_doctor) {
                console.log(`Agregando doctor ID: ${idDoctor}`);
                await client.query(queryAgregarDoctores, [id_usuario, idDoctor]);
            }
        } else {
            console.log("No hay cambios en los doctores asociados. No se requiere actualización.");
        }
    
        await client.query('COMMIT');
    
        return { mensaje: 'Asistente Administrativo actualizado con doctores asociados' };
    } catch (error) {
        await client.query('ROLLBACK'); 
        console.error('Error al actualizar asistente administrativo:', error);
        throw new Error('Error al actualizar asistente administrativo');
    }
};

router.get('/', async (req, res) => {
    try {
        const usuarios = await obtenerPerfilesUsuarios();
        res.json(usuarios);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

router.get('/:idUsuario', async (req, res) => {
    const { idUsuario } = req.params;
    try {
        const usuario = await obtenerUsuarioPorId(idUsuario);
        if (!usuario) {
            return res.status(404).send('Usuario no encontrado');
        }
        res.json(usuario);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

router.put('/:idUsuario', async (req, res) => {
    const { idUsuario } = req.params;
    const datosActualizados = req.body;

    try {
        const usuarioTipo = await obtenerUsuarioPorId(idUsuario);
        if (!usuarioTipo) {
            return res.status(404).send('Usuario no encontrado');
        }

        if (usuarioTipo.id_tipo_usuario === 1) {
            const result = await actualizarAdministrador(idUsuario, datosActualizados);
            return res.json(result);
        } else if (usuarioTipo.id_tipo_usuario === 2) { 
            const result = await actualizarDoctor(idUsuario, datosActualizados);
            return res.json(result);
        } else if (usuarioTipo.id_tipo_usuario === 3) { 
            const result = await actualizarAsistente(idUsuario, datosActualizados);
            return res.json(result);
        } else {
            return res.status(400).send('Tipo de usuario no reconocido');
        }
    } catch (error) {
        res.status(500).send(error.message);
    }
});




module.exports = router;
