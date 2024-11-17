const express = require('express');
const client = require('./db');
const pdf = require('html-pdf');
const router = express.Router();

router.get('/doctor/:id_usuario', async (req, res) => {
    const { id_usuario } = req.params;

    try {
        const doctorQuery = `
            SELECT d.id_doctor, 
            CONCAT(u.nombre, ' ', u.apellido) AS nombre_doctor
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
            SELECT CONCAT(nombre, ' ', apellido) AS nombre_paciente, fecha_nacimiento, DATE_PART('year', AGE(fecha_nacimiento)) AS edad
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
    const { id_doctor, id_paciente, observacion, medicamentos, edad_paciente, id_usuario } = req.body;

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

        const doctor = await client.query(`SELECT CONCAT(u.nombre, ' ', u.apellido) AS nombre_doctor
            FROM doctor d
            JOIN usuario u ON d.id_usuario = u.id_usuario
            WHERE d.id_usuario = $1`, [id_usuario]);
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

      const htmlContent = `
            <!DOCTYPE html>
            <html lang="es">
            <head>
                <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
                <style>
                    body { font-family: 'Arial', sans-serif; background-color: #e9ecef; margin: 20px; padding: 0; }
                    .page-top { max-width: 600px; margin: auto; overflow: hidden; padding-bottom: 40px; } 
                    .body-title { background-color: #6f8caa; color: white; padding: 30px; text-align: center;}
                    .title { font-size: 2em; font-family: 'Times New Roman', Times, serif; font-style: italic; }
                    .prescription-container {padding: 30px; background-color: #e6e6e6; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
                    .patient-info { padding: 20px; background-color: #e6e6e6; border-top: 4px solid #000; }
                    .info-line { display: flex; justify-content: space-between; margin-top: 20px; } 
                    .info-line p { margin: 0; width: 48%; }
                    .signature { margin-top: 100px; text-align: center; font-style: italic; } 
                    .signature-line { border-top: 1px solid #000; width: 300px; margin: 0 auto; }
                    .doctor { text-align: center; font-style: italic; margin-bottom: 20px; } 
                </style>
            </head>
            <body>
                <div class="page-top">
                    <div class="body-title">
                        <h1 class="title">Clinica "Baez Soto S. R. L."</h1>
                        <p>"SERVICIO DE SALUD DE ALTA CALIDAD AL ALCANCE DE TODOS"</p>
                        <p>C/Chefito Batista No. 7, La Vega, Rep Dom</p>
                        <p>Tel.: 8095732737 | Fax.: 8095732737 | RNC: 8095732737</p>
                    </div>
                    <div class="prescription-container">
                        <h2 class="doctor">${recetaData.doctor.nombre_doctor}</h2>
                        ${recetaData.medicamentos.map(med => `
                            <div>
                                <h2>${med.nombre}</h2>
                                <p>Uso: ${med.uso}, Cantidad: ${med.cantidad}, Frecuencia: ${med.frecuencia}, Tiempo: ${med.tiempo}</p>
                            </div>
                        `).join('')}
                        ${recetaData.observacion ? `<p class="doctor">${recetaData.observacion}</p>` : ''}
                    </div>
                    <div class="patient-info">
                        <div class="info-line">
                            <p><strong>Nombre del Paciente:</strong> ${recetaData.paciente.nombre}</p>
                            <p><strong>Edad:</strong> ${recetaData.paciente.edad}</p>
                        </div>
                        <div class="info-line">
                            <p><strong>Cédula:</strong> ${recetaData.paciente.cedula}</p>
                            <p><strong>Fecha:</strong> ${recetaData.fecha}</p>
                        </div>
                        <div class="signature">
                            <div class="signature-line"></div>
                            <p>Firma Doctor</p>
                        </div>
                    </div>
                </div>
            </body>
            </html>
        `;

        pdf.create(htmlContent, { format: 'A4' }).toBuffer((err, buffer) => {
            if (err) {
                console.error('Error generando el PDF:', err);
                return res.status(500).json({ message: 'Error generando el reporte PDF' });
            }

            res.setHeader('Content-Type', 'application/pdf');
            res.setHeader('Content-Disposition', 'attachment; filename="receta.pdf"');
            res.send(buffer);
        });

    } catch (error) {
        console.error('Error al registrar la receta y generar PDF:', error);
        res.status(500).json({ message: 'Error al registrar la receta o generar el PDF' });
    }
});

router.get('/recetasPaciente', async (req, res) => {
    const { id_paciente } = req.query;
    if (!id_paciente) return res.status(400).json({ error: "Id del paciente requerido" });

    try {
        const result = await client.query(`
            SELECT r.id_doctor, CONCAT(u.nombre, ' ', u.apellido) AS doctor, 
                   CONCAT(p.nombre, ' ', p.apellido) AS paciente,
                   r.fecha_receta, r.medicamento, r.uso, r.cantidad, r.frecuencia, 
                   r.tiempo, r.observacion 
            FROM receta r
            JOIN doctor d ON r.id_doctor = d.id_doctor
            JOIN usuario u ON d.id_usuario = u.id_usuario
            JOIN paciente p ON r.id_paciente = p.id_paciente
            WHERE r.id_paciente = $1
        `, [id_paciente]);

        res.json(result.rows);
    } catch (error) {
        console.error("Error al obtener recetas:", error);
        res.status(500).json({ error: "Error al obtener recetas" });
    }
});


module.exports = router;
