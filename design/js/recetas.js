const express = require('express');
const client = require('./db'); 
const router = express.Router();
const jsreport = require('jsreport-core')();
const fs = require('fs');
const path = require('path');
const handlebars = require('jsreport-handlebars');
const htmlPdfmake = require('jsreport-html-to-pdfmake'); 

jsreport.init().catch((err) => {
    console.error('Error initializing jsreport:', err);
});
jsreport.use(handlebars);
jsreport.use(htmlPdfmake); 

router.get('/doctor/:id_usuario', async (req, res) => {
    const { id_usuario } = req.params;

    try {
        const doctorQuery = `
            SELECT d.id_doctor, 
            CONCAT (u.nombre, ' ', u.apellido) AS nombre_doctor
            FROM doctor d
            JOIN usuario u ON d.id_usuario = u.id_usuario
            WHERE d.id_usuario = $1
        `;

        const doctorResult = await client.query(doctorQuery, [id_usuario]);

        if (doctorResult.rows.length > 0) {
            res.status(200).json(doctorResult.rows[0]); 
        } else {
            res.status(404).json({ message: 'Doctor no encontrado' });
        }
    } catch (error) {
        console.error('Error al obtener los datos del doctor', error);
        res.status(500).json({ message: 'Error al obtener los datos del doctor' });
    }
});

router.get('/paciente/:id_paciente', async (req, res) => {
    const { id_paciente } = req.params;

    try {
        const pacienteQuery = `
            SELECT CONCAT (nombre, ' ', apellido) AS nombre_paciente, fecha_nacimiento, DATE_PART('year', AGE(fecha_nacimiento)) AS edad
            FROM paciente
            WHERE id_paciente = $1
        `;

        const pacienteResult = await client.query(pacienteQuery, [id_paciente]);

        if (pacienteResult.rows.length > 0) {
            res.status(200).json(pacienteResult.rows[0]); 
        } else {
            res.status(404).json({ message: 'Paciente no encontrado' });
        }
    } catch (error) {
        console.error('Error al obtener los datos del paciente', error);
        res.status(500).json({ message: 'Error al obtener los datos del paciente' });
    }
});

router.post('/registrarReceta', async (req, res) => {
    const { id_doctor, id_paciente, observacion, medicamentos, edad_paciente } = req.body;

    try {
        const nombresMedicamentos = medicamentos.map(m => m.nombre).join('; ');
        const usosMedicamentos = medicamentos.map(m => m.uso).join('; ');
        const cantidadesMedicamentos = medicamentos.map(m => m.cantidad).join('; ');
        const frecuenciasMedicamentos = medicamentos.map(m => m.frecuencia).join('; ');
        const tiemposMedicamentos = medicamentos.map(m => m.tiempo).join('; ');

        await client.query(
            `INSERT INTO receta (id_doctor, id_paciente, medicamento, uso, cantidad, frecuencia, tiempo, observacion, estado, fecha_receta) 
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, true, NOW())`,
            [
                id_doctor,
                id_paciente,
                nombresMedicamentos,
                usosMedicamentos,
                cantidadesMedicamentos,
                frecuenciasMedicamentos,
                tiemposMedicamentos,
                observacion
            ]
        );

        const doctor = await client.query(`SELECT CONCAT(nombre, ' ', apellido) AS nombre FROM usuario WHERE id_usuario = $1`, [id_doctor]);
        const pacienteData = await client.query(`SELECT CONCAT(nombre, ' ', apellido) AS nombre, cedula FROM paciente WHERE id_paciente = $1`, [id_paciente]);
        const fecha = new Date().toLocaleDateString();

        const recetaData = {
            doctor: doctor.rows[0],
            paciente: {
                nombre: pacienteData.rows[0].nombre,
                edad: edad_paciente,  
                cedula: pacienteData.rows[0].cedula
            },
            fecha,
            medicamentos,
            observacion
        };

        const reportResult = await jsreport.render({
            template: {
                content: fs.readFileSync(path.join('C:', 'Users', 'Jatnna Reinoso', 'reporte', 'jsreportapp', 'data', 'techmedic', 'recetasMedicas', 'content.handlebars'), 'utf8'),
                engine: 'handlebars',
                recipe: 'html-to-pdfmake',  
            },
            data: recetaData
        });

        res.setHeader('Content-Disposition', 'inline; filename=receta.pdf');
        res.setHeader('Content-Disposition', 'attachment; filename=receta.pdf');
        
        reportResult.stream.pipe(res);
    } catch (error) {
        console.error('Error al registrar la receta y generar PDF:', error);
        res.status(500).json({ message: 'Error al registrar la receta o generar el PDF' });
    }
});

module.exports = router;
