const express = require('express');
const client = require('./db'); 
const router = express.Router();
const multer = require('multer');

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const upload = multer({ storage: storage }).fields([
    { name: 'archivos', maxCount: 10 }
]);

router.post('/registerDiagnostico', upload, async (req, res) => {
    const { descripcion, observacion, id_consulta, resultado_pruebas } = req.body;
    const archivos = req.files['archivos'];

    try {
        let rutas = [];
        if (archivos) {
            rutas = archivos.map(file => `uploads/${file.filename}`); // Almacena la ruta de cada archivo
        }

        // El estado se puede tomar directamente desde el cuerpo, pero siempre será true
        const estado = true; 

        const result = await client.query(
            'INSERT INTO diagnostico (id_consulta, descripcion, observacion, ruta_archivos, resultado_pruebas, estado) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id_diagnostico',
            [
                id_consulta,
                descripcion,
                observacion,
                JSON.stringify(rutas), 
                resultado_pruebas,
                estado // El estado se manda como true
            ]
        );

        res.status(201).json({
            message: 'Diagnóstico registrado exitosamente',
            id_diagnostico: result.rows[0].id_diagnostico,
        });
    } catch (error) {
        console.error('Error al registrar el diagnóstico:', error);
        res.status(500).json({
            message: 'Error al registrar el diagnóstico',
            error: error.message,
        });
    }
});

module.exports = router;
